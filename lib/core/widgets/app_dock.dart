import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

import '../theme/theme.dart';
import 'dock_count_badge.dart';

enum AppDockTab { home, trash, settings }

/// Floating frosted bottom dock — prototype `Declutter.dc.html` / SCREENS.md.
class AppDock extends StatelessWidget {
  const AppDock({
    super.key,
    required this.current,
    required this.onChanged,
    this.keyId,
    this.trashBadgeCount = 0,
    this.trashBadgeSemanticsLabel = '',
  });

  static const _itemSize = 54.0;
  static const _itemGap = 8.0;
  static const _slotStride = _itemSize + _itemGap;
  static const _outerPadding = 9.0;

  final AppDockTab current;
  final ValueChanged<AppDockTab> onChanged;
  final Key? keyId;
  final int trashBadgeCount;
  final String trashBadgeSemanticsLabel;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;
    final index = AppDockTab.values.indexOf(current);
    final radius = BorderRadius.circular(dt.radiusFull);

    return Padding(
      key: keyId,
      padding: EdgeInsets.only(bottom: dt.x6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Shadow must sit outside [ClipRRect] or it is clipped away.
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: radius,
              boxShadow: dt.shadowDockFloating,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: radius,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: dt.white.withValues(alpha: 0.82),
                        borderRadius: radius,
                        border: Border.all(color: dt.dockHairlineBorder),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(_outerPadding),
                        child: SizedBox(
                          height: _itemSize,
                          width: _itemSize * 3 + _itemGap * 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(_outerPadding),
                  child: SizedBox(
                    height: _itemSize,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 420),
                          curve: AppMotion.bouncyCurve,
                          left: index * _slotStride,
                          top: 0,
                          width: _itemSize,
                          height: _itemSize,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: dt.dockIndicatorGradient,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _DockItem(
                              icon: PhosphorIconsRegular.house,
                              selectedIcon: PhosphorIconsFill.house,
                              selected: current == AppDockTab.home,
                              onTap: () => onChanged(AppDockTab.home),
                            ),
                            const SizedBox(width: _itemGap),
                            _DockItem(
                              icon: PhosphorIconsRegular.trash,
                              selectedIcon: PhosphorIconsFill.trash,
                              selected: current == AppDockTab.trash,
                              onTap: () => onChanged(AppDockTab.trash),
                              badge: DockCountBadge(
                                count: trashBadgeCount,
                                semanticsLabel: trashBadgeSemanticsLabel,
                              ),
                            ),
                            const SizedBox(width: _itemGap),
                            _DockItem(
                              icon: PhosphorIconsRegular.gear,
                              selected: current == AppDockTab.settings,
                              onTap: () => onChanged(AppDockTab.settings),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DockItem extends StatefulWidget {
  const _DockItem({
    required this.icon,
    required this.selected,
    required this.onTap,
    this.selectedIcon,
    this.badge,
  });

  final IconData icon;
  final IconData? selectedIcon;
  final bool selected;
  final VoidCallback onTap;
  final Widget? badge;

  @override
  State<_DockItem> createState() => _DockItemState();
}

class _DockItemState extends State<_DockItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final dt = context.decluttrTheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Transform.scale(
        scale: _pressed ? 0.92 : 1,
        child: SizedBox(
          width: AppDock._itemSize,
          height: AppDock._itemSize,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Icon(
                widget.selected && widget.selectedIcon != null
                    ? widget.selectedIcon!
                    : widget.icon,
                color: widget.selected ? dt.white : dt.dockInactive,
                size: widget.icon == PhosphorIconsRegular.gear ? 22 : 24,
              ),
              if (widget.badge != null)
                Positioned(
                  top: -dt.x1,
                  right: -dt.x1,
                  child: widget.badge!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
