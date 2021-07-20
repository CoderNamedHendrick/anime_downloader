import 'package:anime_downloader/common_widgets/text_widget.dart';
import 'package:anime_downloader/model/box.dart';
import 'package:anime_downloader/model/recent_search.dart';
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

  Future addRecentSearch(String title, String imgUrl, String link) {
    final recentSearch = RecentSearch()
      ..title = title
      ..imgUrl = imgUrl
      ..link = link;
    final box = Boxes.getRecentSearches();
    box.add(recentSearch);
  }

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
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextWidget(
                            title: 'Name',
                            input: title,
                            type: 'searchScreen',
                          ),
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
          onTap: () {
            addRecentSearch(title, imgUrl, link);
            return DescriptionScreen.show(
              context,
              link: link,
              imageUrl: imgUrl,
            );
          }),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
