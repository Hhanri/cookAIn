import 'package:cookain/auth/data/data_sources/auth_remote_firebase_data_source.dart';
import 'package:cookain/auth/data/repository/auth_repository_implementation.dart';
import 'package:cookain/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:cookain/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:cookain/auth/domain/use_cases/user_changes_use_case.dart';
import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {
  final fai = mockFAI;
  final googleSignIn = mockGoogleSignIn;
  
  final dataSource = AuthRemoteFirebaseDataSource(fai: fai, googleSignIn: googleSignIn);
  final repo = AuthRepositoryImplementation(dataSource: dataSource);
  
  final signInWithGoogleUseCase = SignInWithGoogleUseCase(repo);
  final signOutUseCase = SignOutUseCase(repo);
  final userChangesUseCase = UserChangesUseCase(repo);
  
  final AuthCubit cubit = AuthCubit(
    signInWithGoogleUseCase: signInWithGoogleUseCase,
    signOutUseCase: signOutUseCase,
    userChangesUseCase: userChangesUseCase
  );
  
  group('auth cubit test', () {

    test('cubit initial state', () {
      expect(cubit.state, const AuthSignedOut(isLoading: false),);
    });

    test('sign in', () async {
      cubit.init();

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AuthSignedOut(isLoading: true),
          const AuthSignedIn(isLoading: false)
        ])
      );
      await cubit.signInWithGoogle();
    });

    test('sign out', () async {
      expectLater(
        cubit.stream,
        emitsInOrder([
          const AuthSignedIn(isLoading: true),
          // Since MockGoogleSignIn doesn't implement Sign Out, following line won't be emitted
          // const AuthSignedOut(isLoading: false)
        ])
      );
      await cubit.signOut();
    });

  });
}