import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_dock.dart';

/// When a full-screen route (e.g. batch picker) pops back to [MainShellPage],
/// apply this dock tab on the next frame.
class MainShellDockIntentNotifier extends Notifier<AppDockTab?> {
  @override
  AppDockTab? build() => null;

  void setTab(AppDockTab tab) => state = tab;

  AppDockTab? take() {
    final tab = state;
    state = null;
    return tab;
  }
}

final mainShellDockIntentProvider =
    NotifierProvider<MainShellDockIntentNotifier, AppDockTab?>(
  MainShellDockIntentNotifier.new,
);
