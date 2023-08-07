import 'package:cookain/auth/data/data_sources/auth_data_source_interface.dart';
import 'package:cookain/auth/domain/repository/auth_repository_interface.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/execute.dart';
import 'package:cookain/core/result/success.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImplementation<T> implements AuthRepositoryInterface<T> {

  final AuthDataSourceInterface<T> dataSource;

  AuthRepositoryImplementation({required this.dataSource});

  @override
  Future<Either<Failure, Success>> signInWithGoogle() async {
    return execute(dataSource.signInWithGoogle);
  }

  @override
  Future<Either<Failure, Success>> signOut() async {
    return execute(dataSource.signOut);
  }
  

  @override
  Stream<T> userChanges() {
    return dataSource.userChanges();
  }

}