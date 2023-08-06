part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends MyBlocState {
  const AuthState({required super.isLoading});
}

class AuthSignedIn extends AuthState {
  const AuthSignedIn({required super.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut({required super.isLoading});

  @override
  List<Object?> get props => [isLoading];
}