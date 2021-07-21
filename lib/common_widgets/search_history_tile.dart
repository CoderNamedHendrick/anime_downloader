import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SearchHistoryTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String imgUrl;
  final Widget trailing;

  const SearchHistoryTile({this.onTap, this.title, this.imgUrl, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(imgUrl),
              )),
            ),
            AutoSizeText(
              title,
              textScaleFactor: 0.8,
              presetFontSizes: [10, 6, 4],
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        trailing,
      ],
    );
  }
}
