import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecentSearch extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String link;

  const RecentSearch({this.title, this.imgUrl, this.link});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,
      child: Row(
        children: [
          Container(
            color: Theme.of(context).accentColor,
            width: MediaQuery.of(context).size.width / 2.2,
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Container(
                  height: 50,
                  width: 40,
                  child: Placeholder(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    this.title,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
