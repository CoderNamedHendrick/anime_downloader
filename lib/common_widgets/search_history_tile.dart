import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SearchHistoryTile extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String imgUrl;
  final Widget? trailing;

  const SearchHistoryTile(
      {this.onTap, required this.title, required this.imgUrl, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Row(
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
              Container(
                width: (MediaQuery.of(context).size.width - 40 - 24) * 0.75,
                child: AutoSizeText(
                  title,
                  textScaleFactor: 0.8,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
