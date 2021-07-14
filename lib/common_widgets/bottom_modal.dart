import 'package:anime_downloader/common_widgets/show_exception_alert_dialog.dart';
import 'package:anime_downloader/screens/signin/sign_in_manager.dart';
import 'package:anime_downloader/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBottomModal extends StatefulWidget {
  const AppBottomModal(
      {Key key, @required this.manager, @required this.isLoading});
  final SignInManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) => AppBottomModal(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  @override
  _AppBottomModalState createState() => _AppBottomModalState();
}

class _AppBottomModalState extends State<AppBottomModal> {
  Future<bool> _signInWithGoogle(BuildContext context) async {
    try {
      await widget.manager.signInWithGoogle();
      return true;
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
    return false;
  }

  Future<bool> _signInWithTwitter(BuildContext context) async {
    try {
      await widget.manager.signInWithTwitter();
      return true;
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
    return false;
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(
        maxHeight: height / 3,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(14.0),
        child: Column(
          children: [
            Text(
              "Sign In options",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              height: height / 10,
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 1350),
              alignment: Alignment.center,
              firstChild: _signInOptions(),
              firstCurve: Curves.ease,
              secondChild: Container(
                height: 100,
                width: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
              layoutBuilder: (Widget topChild, Key topChildKey,
                  Widget bottomChild, Key bottomChildKey) {
                return Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Positioned(key: topChildKey, child: topChild),
                    Positioned(
                      key: bottomChildKey,
                      child: bottomChild,
                      left: 0,
                      right: 0,
                    ),
                  ],
                );
              },
              crossFadeState: !widget.isLoading
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ],
        ),
      ),
    );
  }

  _signInOptions() {
    return Material(
      child: Column(
        children: [
          InkWell(
            onTap: widget.isLoading
                ? null
                : () async {
                    bool result = await _signInWithTwitter(context);
                    if (result) {
                      Navigator.of(context).pop();
                    }
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/twitter-logo.png'),
                    ),
                  ),
                ),
                Text("Sign In with Twitter"),
              ],
            ),
          ),
          SizedBox(height: 12),
          InkWell(
            onTap: widget.isLoading
                ? null
                : () async {
                    bool result = await _signInWithGoogle(context);
                    if (result) {
                      Navigator.of(context).pop();
                    }
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/google-logo.png'),
                    ),
                  ),
                ),
                Text("Sign In with Google"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
