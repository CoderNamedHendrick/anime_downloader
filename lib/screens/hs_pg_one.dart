import 'package:anime_downloader/common_widgets/page_one_horizontal_list.dart';
import 'package:anime_downloader/common_widgets/recent_searches_widget.dart';
import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  List _demoItems = ['One', 'Two', 'Three', 'Four', 'Five', 'Six'];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [

      ],
    );
  }
}

Widget Container_dub(BuildContext context, List demoItems){
  return Container(
    color: Theme.of(context).accentColor,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Searches'),
          SizedBox(height: 12),
          RecentSearchWidget(),
          RecentSearchWidget(),
          SizedBox(height: 4),
          PageOneHorizontalList(
            title: 'Latest Releases',
            list: demoItems,
          ),
          PageOneHorizontalList(
            title: 'Trending',
            list: demoItems,
          ),
          Text('Genre'),
          PageOneHorizontalList(title: 'Dance', list: demoItems),
        ],
      ),
    ),
  );
}