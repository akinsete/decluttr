/// Domain-level failure codes for Decluttr.
sealed class AppFailure {
  const AppFailure(this.code, {this.message});

  final String code;
  final String? message;
}

final class PermissionDeniedFailure extends AppFailure {
  const PermissionDeniedFailure({super.message})
      : super('permission_denied');
}

final class PhotosLoadFailure extends AppFailure {
  const PhotosLoadFailure({super.message}) : super('photos_load');
}

final class ContactsLoadFailure extends AppFailure {
  const ContactsLoadFailure({super.message}) : super('contacts_load');
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure({super.message}) : super('network');
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure({super.message}) : super('unknown');
}

final class StorageFailure extends AppFailure {
  const StorageFailure({super.message}) : super('storage');
}
