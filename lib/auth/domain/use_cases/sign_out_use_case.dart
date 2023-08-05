import 'package:cookain/auth/domain/repository/auth_repository_interface.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:dartz/dartz.dart';

class SignOutUseCase {

  final AuthRepositoryInterface repo;

  SignOutUseCase(this.repo);

  Future<Either<Failure, Success>> call() {
    return repo.signOut();
  }

}