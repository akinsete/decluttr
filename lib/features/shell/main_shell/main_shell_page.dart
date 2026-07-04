import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/testing/widget_keys.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../app/router/app_router.dart';

@RoutePage()
class MainShellPage extends ConsumerWidget {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      key: WidgetKeys.mainShell,
      routes: [
        HomeRoute(),
        TrashRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final dockTab = switch (tabsRouter.activeIndex) {
          0 => AppDockTab.home,
          1 => AppDockTab.trash,
          _ => AppDockTab.settings,
        };

        return Scaffold(
          backgroundColor: context.decluttrTheme.canvas,
          extendBody: true,
          body: Stack(
            fit: StackFit.expand,
            children: [
              child,
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AppDock(
                  keyId: WidgetKeys.appDock,
                  current: dockTab,
                  onChanged: (tab) {
                    final index = switch (tab) {
                      AppDockTab.home => 0,
                      AppDockTab.trash => 1,
                      AppDockTab.settings => 2,
                    };
                    tabsRouter.setActiveIndex(index);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
