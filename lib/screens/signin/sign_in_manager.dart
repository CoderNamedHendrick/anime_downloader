import 'package:anime_downloader/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SignInManager {
  SignInManager({required this.auth, required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<User?> _signIn(Future<User?> Function() signInMethod) async{
    try{
      isLoading.value = true;
      return await signInMethod();
    } catch(e) {
      isLoading.value = false;
      rethrow;
    }
  }
  Future<User?> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
  Future<User?> signInWithTwitter() async => await _signIn(auth.signInWithTwitter);
}