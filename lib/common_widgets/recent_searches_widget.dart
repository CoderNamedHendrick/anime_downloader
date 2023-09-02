import 'package:anime_downloader/screens/home/desc_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class RecentSearchWidget extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String link;

  const RecentSearchWidget({required this.title, required this.imgUrl, required this.link});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DescriptionScreen.show(
        context,
        link: link,
        imageUrl: imgUrl,
      ),
      child: Row(
        children: [
          Container(
            color: Theme.of(context).colorScheme.secondary,
            width: MediaQuery.of(context).size.width / 2.2,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imgUrl),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: (MediaQuery.of(context).size.width / 2.2 - 40) * 0.8,
                    child: AutoSizeText(
                      this.title,
                      maxLines: 1,
                      textScaleFactor: 0.8,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
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
