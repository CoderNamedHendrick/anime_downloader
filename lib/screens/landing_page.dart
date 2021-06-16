import 'package:anime_downloader/screens/home/home_screen.dart';
import 'package:anime_downloader/screens/signin/signin_page.dart';
import 'package:anime_downloader/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          print('Something happened here');
          if (user == null) {
           return SignInPage.create(context);
          }
          return HomeScreen();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class DemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Screen'),
        actions: [
          TextButton(
            child: Text('Logout'),
            onPressed: () => auth.signOut(),
          )
        ],
      ),
    );
  }
}