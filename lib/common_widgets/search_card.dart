import 'package:anime_downloader/common_widgets/text_widget.dart';
import 'package:anime_downloader/screens/home/desc_screen.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    Key key,
    this.title,
    this.releaseDate,
    this.imgUrl,
    this.link,
  }) : super(key: key);

  final String title;
  final String releaseDate;
  final String imgUrl;
  final String link;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        child: Card(
          shadowColor: Colors.grey,
          elevation: 8,
          child: Container(
            child: Column(
              children: [
                Flexible(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextWidget(
                          title: 'Name',
                          input: title,
                          type: 'searchScreen',
                        ),
                        SizedBox(height: 12),
                        TextWidget(
                          title: 'Release',
                          input: releaseDate,
                          type: 'searchScreen',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DescriptionScreen(
              link: link,
              imageUrl: imgUrl,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchCardSkeleton extends StatelessWidget {
  const SearchCardSkeleton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shadowColor: Colors.grey,
        elevation: 8,
        child: Container(
          child: Column(
            children: [
              Flexible(
                flex: 7,
                child: SkeletonAnimation(
                  curve: Curves.decelerate,
                  child: Container(
                    color: Colors.grey[500],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SkeletonAnimation(
                        child: Container(
                          height: 22,
                          width: MediaQuery.of(context).size.width * 0.6,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 12),
                      SkeletonAnimation(
                        child: Container(
                          height: 22,
                          width: MediaQuery.of(context).size.width * 0.4,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
