import 'package:cookain/auth/data/data_sources/auth_remote_firebase_data_source.dart';
import 'package:cookain/auth/data/repository/auth_repository_implementation.dart';
import 'package:cookain/auth/domain/use_cases/user_changes_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../default/mock_firebase.dart';

void main() {
  final fai = mockFAI;
  final googleSignIn = mockGoogleSignIn;
  final dataSource = AuthRemoteFirebaseDataSource(fai: fai, googleSignIn: googleSignIn);
  final repo = AuthRepositoryImplementation(dataSource: dataSource);
  final useCase = UserChangesUseCase(repo);

  test('user changes', () async {

    final stream = useCase.call();
    expect(stream, const TypeMatcher<Stream>());
  });

}