import 'package:anime_downloader/common_widgets/recent_searches_widget.dart';
import 'package:anime_downloader/model/recent_search.dart';
import 'package:flutter/material.dart';

class Recents extends StatelessWidget {
  Recents(this.recentSearch);
  final List<RecentSearch> recentSearch;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: recentSearch.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => RecentSearchWidget(
        title: recentSearch[index].title,
        imgUrl: recentSearch[index].imgUrl,
        link: recentSearch[index].link,
      ),
    );
  }
}
