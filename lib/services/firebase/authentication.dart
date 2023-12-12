import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get getUserChanges {
    return _firebaseAuth.authStateChanges();
  }

  String? email() {
    return _firebaseAuth.currentUser!.email ?? "";
  }

  String id() {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<User?> signInUsingEmailAndPassword(
    String email,
    String password,
  ) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user;
  }

  Future<User?> signUpUsingEmailAndPassword(
      String email, String password) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user;
  }

  Future<User?> sigInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final user = await FirebaseAuth.instance.signInWithCredential(credential);
    // Once signed in, return the UserCredential
    return user.user;
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}
