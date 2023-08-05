import 'package:cookain/core/result/success.dart';

abstract class AuthDataSourceInterface<T> {

  Future<Success> signInWithGoogle();
  Future<Success> signOut();
  Stream<T> userChanges();

}