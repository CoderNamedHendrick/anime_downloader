import 'package:anime_downloader/screens/home_page.dart';
import 'package:anime_downloader/services/auth.dart';
import 'package:anime_downloader/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Landing extends StatelessWidget {
  const Landing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          print('we created the provider');
          print('user object $user');
          if (user == null) return HomeScreen();
          return Provider<Database>(
            create: (_) => FirestoreDatabase(
              uid: user.uid,
              email: user.email,
            ),
            child: HomeScreen(),
          );
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
