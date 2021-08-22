import 'package:anime_downloader/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Saved extends StatelessWidget {
  const Saved({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<AuthBase>(context, listen:false).currentUser;
    return StreamBuilder<>(
      stream: null,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
        );
      }
    );
  }
}
