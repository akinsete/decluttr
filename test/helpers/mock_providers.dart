import 'package:decluttr/features/shared/domain/repositories/auth_repository.dart';
import 'package:decluttr/features/shared/domain/repositories/photos_repository.dart';
import 'package:decluttr/features/shared/domain/repositories/swipe_stats_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';

export 'mock_providers.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepository>(),
  MockSpec<FirebaseAuth>(),
  MockSpec<User>(),
  MockSpec<UserCredential>(),
  MockSpec<PhotosRepository>(),
  MockSpec<SwipeStatsRepository>(),
])
void main() {}
