import 'package:flutter/material.dart';
import 'package:anime_downloader/services/auth.dart';


class AuthProvider extends InheritedWidget{
  AuthProvider({required this.auth, required this.child}) : super(child: child);
  final AuthBase auth;
  final Widget child;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static AuthBase? of(BuildContext context){
    AuthProvider? provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider?.auth;
  }
}