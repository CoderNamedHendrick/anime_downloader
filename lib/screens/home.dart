import 'package:anime_downloader/common_widgets/page_one_horizontal_list.dart';
import 'package:anime_downloader/common_widgets/recent_searches_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _demoItems = ['One', 'Two', 'Three', 'Four', 'Five', 'Six'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container_dub(context, _demoItems),
    );
  }
}

Widget Container_dub(BuildContext context, List demoItems) {
  List genres = ['Action', 'Drama', 'Hentai', 'Spice of life', 'Magic'];
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Recent Searches', style: Theme.of(context).textTheme.headline1,),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(children: [
                RecentSearch(),
                RecentSearch(),
              ],),
              Row(children: [
                RecentSearch(),
                RecentSearch(),
              ],),
            ],
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 270,
          child: PageOneHorizontalList(title: 'Latest', list: demoItems),
        ),
        SizedBox(height: 12),
        Text('Genre', style: Theme.of(context).textTheme.headline1,),
        SizedBox(height: 12),

      ],
    ),
  );
}
