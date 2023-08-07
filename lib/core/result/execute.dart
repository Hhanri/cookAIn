import 'package:cookain/core/result/failure.dart';
import 'package:dartz/dartz.dart';

Future<Either<Failure, T>> execute<T>(
  Future<T> Function() function
) async {
  try {
    final res = await function();
    return Right(res);
  } on Failure catch(e) {
    return Left(e);
  } catch(e) {
    return Left(Failure(message: e.toString()));
  }
}