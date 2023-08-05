import 'package:cookain/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../default/mock_firebase.dart';

void main() {
  final fai = mockFAI;
  final googleSignIn = mockGoogleSignIn;
  final dataSource = AuthRemoteDataSource(fai: fai, googleSignIn: googleSignIn);

  group('Auth Repository', () {

    test('signIn', () async {
      final res = await dataSource.signInWithGoogle();
      expect(res, const TypeMatcher<Success>());
    });

    test('signOut', () async {
      /// Google Sign Out is no implemented by MockGoogleSignIn so it will return a failure
      final call = dataSource.signOut();
      expect(() => call, throwsA(const TypeMatcher<Failure>()));
    });

  });
}