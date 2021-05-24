import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 12.0),
          child: Container(
            color: Theme.of(context).accentColor,
            width: MediaQuery.of(context).size.width/2.3,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 40,
                  color: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Enn Enn no Shobuboi',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
