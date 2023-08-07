import 'package:cookain/auth/data/data_sources/auth_remote_firebase_data_source.dart';
import 'package:cookain/auth/data/repository/auth_repository_implementation.dart';
import 'package:cookain/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {
  final fai = mockFAI;
  final googleSignIn = mockGoogleSignIn;
  final dataSource = AuthRemoteFirebaseDataSource(fai: fai, googleSignIn: googleSignIn);
  final repo = AuthRepositoryImplementation(dataSource: dataSource);
  final useCase = SignOutUseCase(repo);

  test('sign out', () async {

    final res = await useCase.call();
    expect(res.isRight(), false);
  });

}