import 'package:cookain/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:cookain/auth/data/repository/auth_repository_implementation.dart';
import 'package:cookain/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../default/mock_firebase.dart';

void main() {
  final fai = mockFAI;
  final googleSignIn = mockGoogleSignIn;
  final dataSource = AuthRemoteDataSource(fai: fai, googleSignIn: googleSignIn);
  final repo = AuthRepositoryImplementation(dataSource: dataSource);
  final useCase = SignInWithGoogleUseCase(repo);

  test('sign in with google', () async {
    /// Google Sign Out is no implemented by MockGoogleSignIn so it will return a failure
    final res = await useCase.call();
    expect(res.isRight(), true);
  });

}