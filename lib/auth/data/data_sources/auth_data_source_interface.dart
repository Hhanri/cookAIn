import 'package:cookain/core/result/success.dart';

abstract class AuthDataSourceInterface {

  Future<Success> signInWithGoogle();
  Future<Success> signOut();

}