import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepositoryInterface<T> {

  Future<Either<Failure, Success>> signInWithGoogle();
  Future<Either<Failure, Success>> signOut();
  Stream<T> userChanges();

}