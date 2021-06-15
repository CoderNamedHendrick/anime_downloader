import 'package:anime_downloader/screens/signin/email_sign_in_form_change_notifier.dart';
import 'package:anime_downloader/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Potaru"),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormChangeNotifier.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
