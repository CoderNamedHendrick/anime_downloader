import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  String title;
  String input;
  String type;
  TextWidget(
      {@required String title, @required String input, @required String type}) {
    this.title = title;
    this.input = input;
    this.type = type;
  }

  @override
  Widget build(BuildContext context) {
    if (type == 'searchScreen') {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$title: ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            Expanded(
              child: Text(
                "$input",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
    } else if (type == 'descriptionScreen') {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$title: ",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
            ),
            Expanded(
              child: Text(
                "$input",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
    }
  }
}
