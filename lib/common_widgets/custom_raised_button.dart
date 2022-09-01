import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton(
      {required this.child,
      this.color,
      this.borderRadius: 2.0,
      this.height: 50.0,
      this.onPressed});

  final Widget child;
  final Color? color;
  final double borderRadius;
  final double height;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ))),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
