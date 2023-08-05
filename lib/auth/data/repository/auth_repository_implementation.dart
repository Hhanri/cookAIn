import 'package:cookain/auth/data/data_sources/auth_data_source_interface.dart';
import 'package:cookain/auth/domain/repository/auth_repository_interface.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImplementation implements AuthRepositoryInterface {

  final AuthDataSourceInterface dataSource;

  AuthRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<Failure, Success>> signInWithGoogle() async {
    return _execute(dataSource.signInWithGoogle);
  }

  @override
  Future<Either<Failure, Success>> signOut() async {
    return _execute(dataSource.signOut);
  }

  Future<Either<Failure, Success>> _execute(Future<void> Function() function) async {
    try {
      await function();
      return const Right(Success());
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

}