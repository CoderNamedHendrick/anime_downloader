import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> get authStateChanges;
  Future<User?> signInWithGoogle();
  Future<User?> signInWithTwitter();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User?> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: 'imJr3lVDEHUatITQkLwBoPwZs',
      apiSecretKey: 'Q90mEFWSoTlJVAEfk6JVqIs9E4xcHxqCqTOj3lGuBBfiDQKqjc',
      redirectURI: 'example://',
    );
    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        final userCredential = await _firebaseAuth.signInWithCredential(
          TwitterAuthProvider.credential(
              accessToken: authResult.authToken ?? '',
              secret: authResult.authTokenSecret ?? ''),
        );
        return userCredential.user;
      case TwitterLoginStatus.cancelledByUser:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      case TwitterLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_TWITTER_LOGIN_FAILED',
          message: authResult.errorMessage,
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    // final twitterLogin = TwitterLogin(
    //   apiKey: CONSUMER_KEY,
    //   apiSecretKey: CONSUMER_KEY_SECRET,
    //   redirectURI: 'example://',
    // );

    await _firebaseAuth.signOut();
  }
}
