import 'package:decluttr/app/router/app_router.dart';
import 'package:decluttr/core/di/providers.dart';
import 'package:decluttr/features/batch/batch_contacts/batch_contacts_notifier.dart';
import 'package:decluttr/features/batch/batch_contacts/batch_contacts_page.dart';
import 'package:decluttr/features/batch/batch_photos/batch_photos_notifier.dart';
import 'package:decluttr/features/batch/batch_photos/batch_photos_page.dart';
import 'package:decluttr/features/duplicates/duplicate_contacts/duplicate_contacts_notifier.dart';
import 'package:decluttr/features/duplicates/duplicate_contacts/duplicate_contacts_state.dart';
import 'package:decluttr/features/duplicates/duplicate_contacts/duplicate_contacts_page.dart';
import 'package:decluttr/features/errors/error/error_page.dart';
import 'package:decluttr/features/errors/error/error_variant.dart';
import 'package:decluttr/features/home/home/home_page.dart';
import 'package:decluttr/features/home/home/home_vm_notifier.dart';
import 'package:decluttr/features/onboarding/splash/splash_page.dart';
import 'package:decluttr/features/onboarding/walkthrough/walkthrough_page.dart';
import 'package:decluttr/features/onboarding/welcome/welcome_page.dart';
import 'package:decluttr/features/permissions/contacts_permission/contacts_permission_page.dart';
import 'package:decluttr/features/permissions/photos_permission/photos_permission_page.dart';
import 'package:decluttr/features/settings/settings/settings_page.dart';
import 'package:decluttr/features/settings/settings/settings_notifier.dart';
import 'package:decluttr/features/settings/settings/settings_state.dart';
import 'package:decluttr/features/settings/sign_in/sign_in_page.dart';
import 'package:decluttr/features/shared/domain/entities/batch_item.dart';
import 'package:decluttr/features/shared/domain/entities/contact_record.dart';
import 'package:decluttr/features/shared/domain/entities/duplicate_group.dart';
import 'package:decluttr/features/shared/domain/entities/swipe_item.dart';
import 'package:decluttr/features/shared/domain/entities/trash_item.dart';
import 'package:decluttr/features/streak/streak/streak_page.dart';
import 'package:decluttr/features/streak/streak/streak_vm_notifier.dart';
import 'package:decluttr/features/swipe/session_summary/session_summary_page.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_notifier.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_state.dart';
import 'package:decluttr/features/swipe/swipe_session/swipe_session_page.dart';
import 'package:decluttr/features/trash/trash/trash_notifier.dart';
import 'package:decluttr/features/trash/trash/trash_page.dart';
import 'package:decluttr/features/trash/trash/trash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

const _swipeArgs = SwipeSessionArgs(
  batchId: '2025-06',
  batchTitle: 'June 2025',
  isPhotos: true,
);

List<Override> _shellHomeOverrides() => [
      appStateProvider.overrideWith(_ReturningAppState.new),
      homeScreenVmProvider.overrideWith(_ReturningHomeVm.new),
      trashUiProvider.overrideWith(_EmptyTrashUi.new),
    ];

void main() {
  group('onboarding goldens', () {
    testWidgets('splash', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'splash_page',
        prefs: prefs,
        settle: false,
        builder: (_) => const SplashPage(),
      );
    }, tags: ['golden']);

    testWidgets('welcome', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'welcome_page',
        prefs: prefs,
        settle: false,
        builder: (_) => const WelcomePage(),
      );
    }, tags: ['golden']);

    testWidgets('walkthrough', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'walkthrough_page',
        prefs: prefs,
        settle: false,
        builder: (_) => const WalkthroughPage(),
      );
    }, tags: ['golden']);
  });

  group('home goldens', () {
    testWidgets('home first visit', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'home_first_visit',
        prefs: prefs,
        overrides: [
          appStateProvider.overrideWith(_FirstVisitAppState.new),
          homeScreenVmProvider.overrideWith(_FirstVisitHomeVm.new),
        ],
        builder: (_) => const HomePage(),
      );
    }, tags: ['golden']);

    testWidgets('home returning', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'home_returning',
        prefs: prefs,
        overrides: [
          appStateProvider.overrideWith(_ReturningAppState.new),
          homeScreenVmProvider.overrideWith(_ReturningHomeVm.new),
        ],
        builder: (_) => const HomePage(),
      );
    }, tags: ['golden']);
  });

  group('settings goldens', () {
    testWidgets('settings', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'settings_page',
        prefs: prefs,
        overrides: [
          appStateProvider.overrideWith(_ReturningAppState.new),
          settingsUiProvider.overrideWith(_DefaultSettingsUi.new),
        ],
        builder: (_) => const SettingsPage(),
      );
    }, tags: ['golden']);
  });

  group('error goldens', () {
    testWidgets('error contacts', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'error_contacts',
        prefs: prefs,
        builder: (_) => const ErrorPage(variant: ErrorVariant.contacts),
      );
    }, tags: ['golden']);

    testWidgets('error photos', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'error_photos',
        prefs: prefs,
        builder: (_) => const ErrorPage(variant: ErrorVariant.photos),
      );
    }, tags: ['golden']);
  });

  group('session goldens', () {
    testWidgets('session summary', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'session_summary',
        prefs: prefs,
        settle: false,
        builder: (_) => const SessionSummaryPage(kept: 5, deleted: 2),
      );
    }, tags: ['golden']);
  });

  group('permissions goldens', () {
    testWidgets('contacts permission', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'contacts_permission',
        prefs: prefs,
        settle: false,
        builder: (_) => const ContactsPermissionPage(),
      );
    }, tags: ['golden']);

    testWidgets('photos permission', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'photos_permission',
        prefs: prefs,
        settle: false,
        builder: (_) => const PhotosPermissionPage(),
      );
    }, tags: ['golden']);
  });

  group('batch goldens', () {
    testWidgets('batch photos empty', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'batch_photos_empty',
        prefs: prefs,
        overrides: [batchPhotosProvider.overrideWith(_EmptyBatchPhotos.new)],
        builder: (_) => const BatchPhotosPage(),
      );
    }, tags: ['golden']);

    testWidgets('batch photos populated', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'batch_photos_populated',
        prefs: prefs,
        overrides: [batchPhotosProvider.overrideWith(_SampleBatchPhotos.new)],
        builder: (_) => const BatchPhotosPage(),
      );
    }, tags: ['golden']);

    testWidgets('batch contacts empty', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'batch_contacts_empty',
        prefs: prefs,
        overrides: [batchContactsProvider.overrideWith(_EmptyBatchContacts.new)],
        builder: (_) => const BatchContactsPage(),
      );
    }, tags: ['golden']);

    testWidgets('batch contacts populated', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'batch_contacts_populated',
        prefs: prefs,
        overrides: [
          batchContactsProvider.overrideWith(_SampleBatchContacts.new),
        ],
        builder: (_) => const BatchContactsPage(),
      );
    }, tags: ['golden']);
  });

  group('swipe goldens', () {
    testWidgets('swipe session', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'swipe_session',
        prefs: prefs,
        settle: false,
        overrides: [
          swipeSessionProvider(_swipeArgs).overrideWith(_LoadedSwipeSession.new),
        ],
        builder: (_) => const SwipeSessionPage(
          batchId: '2025-06',
          batchTitle: 'June 2025',
        ),
      );
    }, tags: ['golden']);
  });

  group('trash goldens', () {
    testWidgets('trash empty', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'trash_empty',
        prefs: prefs,
        overrides: [trashUiProvider.overrideWith(_EmptyTrashUi.new)],
        builder: (_) => const TrashPage(),
      );
    }, tags: ['golden']);

    testWidgets('trash populated', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'trash_populated',
        prefs: prefs,
        overrides: [trashUiProvider.overrideWith(_PopulatedTrashUi.new)],
        builder: (_) => const TrashPage(),
      );
    }, tags: ['golden']);
  });

  group('shell goldens', () {
    testWidgets('main shell home', (tester) async {
      final prefs = await initTestPrefs();
      await runRouterGolden(
        tester,
        baseName: 'main_shell_home',
        prefs: prefs,
        route: const MainShellRoute(children: [HomeRoute()]),
        overrides: _shellHomeOverrides(),
      );
    }, tags: ['golden']);

    testWidgets('main shell trash', (tester) async {
      final prefs = await initTestPrefs();
      await runRouterGolden(
        tester,
        baseName: 'main_shell_trash',
        prefs: prefs,
        route: const MainShellRoute(children: [TrashRoute()]),
        overrides: _shellHomeOverrides(),
      );
    }, tags: ['golden']);

    testWidgets('main shell settings', (tester) async {
      final prefs = await initTestPrefs();
      await runRouterGolden(
        tester,
        baseName: 'main_shell_settings',
        prefs: prefs,
        route: const MainShellRoute(children: [SettingsRoute()]),
        overrides: [
          ..._shellHomeOverrides(),
          settingsUiProvider.overrideWith(_DefaultSettingsUi.new),
        ],
      );
    }, tags: ['golden']);
  });

  group('streak goldens', () {
    testWidgets('streak', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'streak_page',
        prefs: prefs,
        overrides: [streakVmProvider.overrideWith(_SampleStreakVm.new)],
        builder: (_) => const StreakPage(),
      );
    }, tags: ['golden']);
  });

  group('duplicates goldens', () {
    testWidgets('duplicate contacts', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'duplicate_contacts',
        prefs: prefs,
        overrides: [
          duplicateContactsProvider.overrideWith(_SampleDuplicateContacts.new),
        ],
        builder: (_) => const DuplicateContactsPage(),
      );
    }, tags: ['golden']);
  });

  group('auth goldens', () {
    testWidgets('sign in', (tester) async {
      final prefs = await initTestPrefs();
      await runThemedGolden(
        tester,
        baseName: 'sign_in_page',
        prefs: prefs,
        builder: (_) => const SignInPage(),
      );
    }, tags: ['golden']);
  });
}

class _FirstVisitAppState extends AppStateNotifier {
  @override
  AppState build() => const AppState(isLoading: false, hasActivity: false);
}

class _ReturningAppState extends AppStateNotifier {
  @override
  AppState build() => const AppState(
        isLoading: false,
        hasActivity: true,
        hapticOn: true,
        notifOn: true,
      );
}

class _FirstVisitHomeVm extends HomeScreenVmNotifier {
  @override
  Future<HomeScreenVm> build() async {
    return const HomeScreenVm(
      isFirstVisit: true,
      streakDays: 0,
      contactsCount: 11,
      photosCount: 95,
      progress: 0,
      kept: 0,
      deleted: 0,
      isLoading: false,
    );
  }
}

class _ReturningHomeVm extends HomeScreenVmNotifier {
  @override
  Future<HomeScreenVm> build() async {
    return const HomeScreenVm(
      isFirstVisit: false,
      streakDays: 4,
      contactsCount: 11,
      photosCount: 95,
      progress: 0.42,
      kept: 128,
      deleted: 64,
      isLoading: false,
    );
  }
}

class _DefaultSettingsUi extends SettingsUiNotifier {
  @override
  SettingsUiState build() => const SettingsUiState();
}

class _EmptyBatchPhotos extends BatchPhotosNotifier {
  @override
  Future<List<BatchItem>> build() async => [];
}

class _EmptyBatchContacts extends BatchContactsNotifier {
  @override
  Future<List<BatchItem>> build() async => [];
}

class _SampleBatchPhotos extends BatchPhotosNotifier {
  @override
  Future<List<BatchItem>> build() async => const [
        BatchItem(
          id: '1',
          kind: BatchKind.photos,
          title: 'June 2025',
          subtitle: '42 photos',
          count: 42,
        ),
        BatchItem(
          id: '2',
          kind: BatchKind.photos,
          title: 'May 2025',
          subtitle: '38 photos',
          count: 38,
          gradientIndex: 1,
        ),
      ];
}

class _SampleBatchContacts extends BatchContactsNotifier {
  @override
  Future<List<BatchItem>> build() async => const [
        BatchItem(
          id: 'dup',
          kind: BatchKind.contacts,
          title: 'Duplicates',
          subtitle: '3 groups',
          count: 3,
          isDuplicates: true,
        ),
        BatchItem(
          id: 'a',
          kind: BatchKind.contacts,
          title: 'A–M',
          subtitle: '42 contacts',
          count: 42,
        ),
      ];
}

class _LoadedSwipeSession extends SwipeSessionNotifier {
  _LoadedSwipeSession() : super(_swipeArgs);

  @override
  SwipeSessionState build() {
    return const SwipeSessionState(
      batchId: '2025-06',
      batchTitle: 'June 2025',
      isPhotos: true,
      isLoading: false,
      items: [
        SwipeItem(
          id: '1',
          title: 'Beach sunset',
          subtitle: '2.4 MB',
          gradientIndex: 0,
        ),
        SwipeItem(
          id: '2',
          title: 'Coffee shop',
          subtitle: '1.1 MB',
          gradientIndex: 1,
        ),
      ],
    );
  }
}

class _EmptyTrashUi extends TrashUiNotifier {
  @override
  TrashUiState build() => const TrashUiState(isLoading: false);
}

class _PopulatedTrashUi extends TrashUiNotifier {
  @override
  TrashUiState build() {
    return TrashUiState(
      isLoading: false,
      reclaimableLabel: '24.5 MB',
      items: [
        TrashItem(
          id: 't1',
          type: TrashItemType.photo,
          title: 'Beach sunset',
          subtitle: '2.4 MB',
          deletedAt: DateTime(2025, 6, 1),
          monthKey: '2025-06',
        ),
        TrashItem(
          id: 't2',
          type: TrashItemType.photo,
          title: 'Coffee shop',
          subtitle: '1.1 MB',
          deletedAt: DateTime(2025, 6, 2),
          monthKey: '2025-06',
        ),
      ],
    );
  }
}

class _SampleStreakVm extends StreakVmNotifier {
  @override
  Future<StreakVm> build() async {
    return const StreakVm(
      currentStreak: 4,
      weekActivity: [true, true, false, true, true, false, false],
      heatmap: [
        2, 1, 0, 3, 1, 0, 2,
        1, 0, 2, 1, 0, 0, 1,
        0, 1, 0, 2, 1, 0, 0,
        1, 0, 0, 1, 2, 0, 1,
        0, 0, 1, 0, 0, 0, 0,
      ],
    );
  }
}

class _SampleDuplicateContacts extends DuplicateContactsNotifier {
  @override
  Future<DuplicateContactsState> build() async {
    return DuplicateContactsState(
      groups: [
        DuplicateGroup(
          id: 'g1',
          displayName: 'Alex Morgan',
          reason: DuplicateReason.samePhone,
          contacts: const [
            ContactRecord(
              id: 'c1',
              displayName: 'Alex Morgan',
              phone: '+1 555-0100',
              email: 'alex@work.com',
            ),
            ContactRecord(
              id: 'c2',
              displayName: 'Alex M.',
              phone: '+1 555-0100',
              email: 'alex@gmail.com',
            ),
          ],
        ),
      ],
    );
  }
}
