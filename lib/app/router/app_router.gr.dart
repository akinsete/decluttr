// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [BatchContactsPage]
class BatchContactsRoute extends PageRouteInfo<void> {
  const BatchContactsRoute({List<PageRouteInfo>? children})
    : super(BatchContactsRoute.name, initialChildren: children);

  static const String name = 'BatchContactsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BatchContactsPage();
    },
  );
}

/// generated route for
/// [BatchPhotosPage]
class BatchPhotosRoute extends PageRouteInfo<void> {
  const BatchPhotosRoute({List<PageRouteInfo>? children})
    : super(BatchPhotosRoute.name, initialChildren: children);

  static const String name = 'BatchPhotosRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BatchPhotosPage();
    },
  );
}

/// generated route for
/// [ContactsPermissionPage]
class ContactsPermissionRoute extends PageRouteInfo<void> {
  const ContactsPermissionRoute({List<PageRouteInfo>? children})
    : super(ContactsPermissionRoute.name, initialChildren: children);

  static const String name = 'ContactsPermissionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContactsPermissionPage();
    },
  );
}

/// generated route for
/// [DuplicateContactsPage]
class DuplicateContactsRoute extends PageRouteInfo<void> {
  const DuplicateContactsRoute({List<PageRouteInfo>? children})
    : super(DuplicateContactsRoute.name, initialChildren: children);

  static const String name = 'DuplicateContactsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DuplicateContactsPage();
    },
  );
}

/// generated route for
/// [ErrorPage]
class ErrorRoute extends PageRouteInfo<ErrorRouteArgs> {
  ErrorRoute({
    Key? key,
    ErrorVariant variant = ErrorVariant.generic,
    List<PageRouteInfo>? children,
  }) : super(
         ErrorRoute.name,
         args: ErrorRouteArgs(key: key, variant: variant),
         initialChildren: children,
       );

  static const String name = 'ErrorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ErrorRouteArgs>(
        orElse: () => const ErrorRouteArgs(),
      );
      return ErrorPage(key: args.key, variant: args.variant);
    },
  );
}

class ErrorRouteArgs {
  const ErrorRouteArgs({this.key, this.variant = ErrorVariant.generic});

  final Key? key;

  final ErrorVariant variant;

  @override
  String toString() {
    return 'ErrorRouteArgs{key: $key, variant: $variant}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ErrorRouteArgs) return false;
    return key == other.key && variant == other.variant;
  }

  @override
  int get hashCode => key.hashCode ^ variant.hashCode;
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [MainShellPage]
class MainShellRoute extends PageRouteInfo<void> {
  const MainShellRoute({List<PageRouteInfo>? children})
    : super(MainShellRoute.name, initialChildren: children);

  static const String name = 'MainShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainShellPage();
    },
  );
}

/// generated route for
/// [PhotosPermissionPage]
class PhotosPermissionRoute extends PageRouteInfo<void> {
  const PhotosPermissionRoute({List<PageRouteInfo>? children})
    : super(PhotosPermissionRoute.name, initialChildren: children);

  static const String name = 'PhotosPermissionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PhotosPermissionPage();
    },
  );
}

/// generated route for
/// [SessionSummaryPage]
class SessionSummaryRoute extends PageRouteInfo<SessionSummaryRouteArgs> {
  SessionSummaryRoute({
    Key? key,
    int kept = 0,
    int deleted = 0,
    String batchId = '',
    bool isPhotos = true,
    List<PageRouteInfo>? children,
  }) : super(
         SessionSummaryRoute.name,
         args: SessionSummaryRouteArgs(
           key: key,
           kept: kept,
           deleted: deleted,
           batchId: batchId,
           isPhotos: isPhotos,
         ),
         initialChildren: children,
       );

  static const String name = 'SessionSummaryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SessionSummaryRouteArgs>(
        orElse: () => const SessionSummaryRouteArgs(),
      );
      return SessionSummaryPage(
        key: args.key,
        kept: args.kept,
        deleted: args.deleted,
        batchId: args.batchId,
        isPhotos: args.isPhotos,
      );
    },
  );
}

class SessionSummaryRouteArgs {
  const SessionSummaryRouteArgs({
    this.key,
    this.kept = 0,
    this.deleted = 0,
    this.batchId = '',
    this.isPhotos = true,
  });

  final Key? key;

  final int kept;

  final int deleted;

  final String batchId;

  final bool isPhotos;

  @override
  String toString() {
    return 'SessionSummaryRouteArgs{key: $key, kept: $kept, deleted: $deleted, batchId: $batchId, isPhotos: $isPhotos}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SessionSummaryRouteArgs) return false;
    return key == other.key &&
        kept == other.kept &&
        deleted == other.deleted &&
        batchId == other.batchId &&
        isPhotos == other.isPhotos;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      kept.hashCode ^
      deleted.hashCode ^
      batchId.hashCode ^
      isPhotos.hashCode;
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInPage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [StreakPage]
class StreakRoute extends PageRouteInfo<void> {
  const StreakRoute({List<PageRouteInfo>? children})
    : super(StreakRoute.name, initialChildren: children);

  static const String name = 'StreakRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StreakPage();
    },
  );
}

/// generated route for
/// [SwipeSessionPage]
class SwipeSessionRoute extends PageRouteInfo<SwipeSessionRouteArgs> {
  SwipeSessionRoute({
    Key? key,
    String batchId = '',
    String batchTitle = '',
    bool isPhotos = true,
    List<PageRouteInfo>? children,
  }) : super(
         SwipeSessionRoute.name,
         args: SwipeSessionRouteArgs(
           key: key,
           batchId: batchId,
           batchTitle: batchTitle,
           isPhotos: isPhotos,
         ),
         rawPathParams: {'batchId': batchId},
         rawQueryParams: {'isPhotos': isPhotos},
         initialChildren: children,
       );

  static const String name = 'SwipeSessionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<SwipeSessionRouteArgs>(
        orElse: () => SwipeSessionRouteArgs(
          batchId: pathParams.getString('batchId', ''),
          isPhotos: queryParams.getBool('isPhotos', true),
        ),
      );
      return SwipeSessionPage(
        key: args.key,
        batchId: args.batchId,
        batchTitle: args.batchTitle,
        isPhotos: args.isPhotos,
      );
    },
  );
}

class SwipeSessionRouteArgs {
  const SwipeSessionRouteArgs({
    this.key,
    this.batchId = '',
    this.batchTitle = '',
    this.isPhotos = true,
  });

  final Key? key;

  final String batchId;

  final String batchTitle;

  final bool isPhotos;

  @override
  String toString() {
    return 'SwipeSessionRouteArgs{key: $key, batchId: $batchId, batchTitle: $batchTitle, isPhotos: $isPhotos}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SwipeSessionRouteArgs) return false;
    return key == other.key &&
        batchId == other.batchId &&
        batchTitle == other.batchTitle &&
        isPhotos == other.isPhotos;
  }

  @override
  int get hashCode =>
      key.hashCode ^ batchId.hashCode ^ batchTitle.hashCode ^ isPhotos.hashCode;
}

/// generated route for
/// [TrashPage]
class TrashRoute extends PageRouteInfo<void> {
  const TrashRoute({List<PageRouteInfo>? children})
    : super(TrashRoute.name, initialChildren: children);

  static const String name = 'TrashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TrashPage();
    },
  );
}

/// generated route for
/// [WalkthroughPage]
class WalkthroughRoute extends PageRouteInfo<void> {
  const WalkthroughRoute({List<PageRouteInfo>? children})
    : super(WalkthroughRoute.name, initialChildren: children);

  static const String name = 'WalkthroughRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WalkthroughPage();
    },
  );
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
    : super(WelcomeRoute.name, initialChildren: children);

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WelcomePage();
    },
  );
}
