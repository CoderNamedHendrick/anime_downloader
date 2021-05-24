import 'package:anime_downloader/common_widgets/horizontal_list_view.dart';
import 'package:flutter/material.dart';

class PageOneHorizontalList extends StatelessWidget {
  const PageOneHorizontalList({this.title, this.list});
  final String title;
  final List list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: 12),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: EdgeInsets.zero,
              child: ListView.separated(
                  itemCount: list.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 8.0,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 180,
                            color: Colors.green,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text('Demon Slayer Mugen Train', style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
