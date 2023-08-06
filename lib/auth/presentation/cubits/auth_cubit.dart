import 'dart:async';

import 'package:cookain/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:cookain/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:cookain/auth/domain/use_cases/user_changes_use_case.dart';
import 'package:cookain/core/cubits/my_bloc_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit<T> extends Cubit<AuthState> {
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignOutUseCase signOutUseCase;
  final UserChangesUseCase<T> userChangesUseCase;
  AuthCubit({
    required this.signInWithGoogleUseCase,
    required this.signOutUseCase,
    required this.userChangesUseCase
  }) : super(const AuthSignedOut(isLoading: false));

  StreamSubscription<T>? userChangesStream;

  void init() async {
    userChangesStream?.cancel();
    userChangesStream = userChangesUseCase.call().listen((event) {
      if (event == null) {
        emit(const AuthSignedOut(isLoading: false));
      } else {
        emit(const AuthSignedIn(isLoading: false));
      }
    });
  }

  Future<void> signInWithGoogle() async {
    emit(const AuthSignedOut(isLoading: true));
    await signInWithGoogleUseCase.call();
  }

  Future<void> signOut() async {
    if (state is! AuthSignedIn) return;
    emit(const AuthSignedIn(isLoading: true));
    await signOutUseCase.call();
  }

  @override
  Future<void> close() async {
    userChangesStream?.cancel();
    userChangesStream = null;
    return super.close();
  }
}
