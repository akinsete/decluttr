import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<User>(),
  MockSpec<UserCredential>(),
])
void main() {}
