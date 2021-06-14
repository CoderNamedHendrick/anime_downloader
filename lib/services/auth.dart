import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Future<FirebaseUser> get currentUser;
  Stream<FirebaseUser> authStateChanges();
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password);
  Future<FirebaseUser> createUserWithEmailAndPassword(
      String email, String password);
  Future<FirebaseUser> signInWithGoogle();
  Future<FirebaseUser> signInWithTwitter();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<FirebaseUser> authStateChanges() => _firebaseAuth.onAuthStateChanged;

  @override
  Future<FirebaseUser> get currentUser => _firebaseAuth.currentUser();

  @override
  Future<FirebaseUser> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }

  @override
  Future<FirebaseUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  @override
  Future<FirebaseUser> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithGoogle(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        return userCredential;
      } else {
        throw FirebaseException(
          plugin: 'Missing Id token',
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    } else {
      throw FirebaseException(
        plugin: 'Operation aborted by user',
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<FirebaseUser> signInWithTwitter() async {
    final tw = TwitterLogin(
        consumerKey: 'imJr3lVDEHUatITQkLwBoPwZs',
        consumerSecret: 'Q90mEFWSoTlJVAEfk6JVqIs9E4xcHxqCqTOj3lGuBBfiDQKqjc');
    final response = await tw.authorize();
    switch (response.status) {
      case TwitterLoginStatus.loggedIn:
        final session = response.session;
        final userCredential = await _firebaseAuth.signInWithTwitter(
          authToken: session.token,
          authTokenSecret: session.secret,
        );
        return userCredential;
        break;
      case TwitterLoginStatus.cancelledByUser:
        throw FirebaseException(
          plugin: 'Login cancelled by user',
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
        break;
      case TwitterLoginStatus.error:
        throw FirebaseException(
          plugin: 'Error with login',
          code: 'ERROR_TWITTER_LOGIN_FAILED',
          message: response.errorMessage,
        );
        break;
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final twitterLogin = TwitterLogin(
        consumerKey: 'imJr3lVDEHUatITQkLwBoPwZs',
        consumerSecret: 'Q90mEFWSoTlJVAEfk6JVqIs9E4xcHxqCqTOj3lGuBBfiDQKqjc');
    await twitterLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
