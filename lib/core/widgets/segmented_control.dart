import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';


class SegmentedControl<T extends Object> extends StatelessWidget {
  const SegmentedControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
    required this.labelBuilder,
  });

  final List<T> segments;
  final T selected;
  final ValueChanged<T> onChanged;
  final String Function(T value) labelBuilder;

  @override
  Widget build(BuildContext context) {
    final typography = context.decluttrTypography;
    return Container(
      padding: EdgeInsets.all(context.decluttrTheme.x1),
      decoration: BoxDecoration(
        color: context.decluttrTheme.surfaceCard,
        borderRadius: BorderRadius.circular(context.decluttrTheme.radiusPill),
      ),
      child: Row(
        children: segments.map((segment) {
          final isSelected = segment == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(segment),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: context.decluttrTheme.x3),
                decoration: BoxDecoration(
                  color: isSelected ? context.decluttrTheme.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(context.decluttrTheme.radiusPill),
                ),
                child: Text(
                  labelBuilder(segment),
                  textAlign: TextAlign.center,
                  style: isSelected
                      ? typography.segmentedLabelSelected
                      : typography.segmentedLabelUnselected,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
