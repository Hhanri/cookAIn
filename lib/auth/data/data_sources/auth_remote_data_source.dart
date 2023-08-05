import 'package:cookain/auth/data/data_sources/auth_data_source_interface.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSource implements AuthDataSourceInterface {

  final FirebaseAuth fai;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSource({required this.fai, required this.googleSignIn});

  @override
  Future<Success> signInWithGoogle() async {
    try {
      final googleAccount = await googleSignIn.signIn();
      if (googleAccount == null) throw 'sign in canceled';

      final googleAuth = await googleAccount.authentication;
      final authCredentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await fai.signInWithCredential(authCredentials);
      return const Success();
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message, code: e.code);
    } catch (e) {
      throw Failure(message: e.toString());
    }

  }

  @override
  Future<Success> signOut() async {
    try {
      if (await googleSignIn.isSignedIn()) await googleSignIn.signOut();
      await fai.signOut();
      return const Success();
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message, code: e.code);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

}