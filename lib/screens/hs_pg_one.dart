import 'package:anime_downloader/common_widgets/horizontal_list_view.dart';
import 'package:anime_downloader/common_widgets/page_one_horizontal_list.dart';
import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  List _demoItems = ['One', 'Two', 'Three', 'Four', 'Five', 'Six'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 12.0),
                    child: Container(
                      color: Colors.grey[600],
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 40,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Enn Enn no'),
                                Text('Shuboutai'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 12.0),
                    child: Container(
                      color: Colors.grey[600],
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 40,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Enn Enn no'),
                                Text('Shuboutai'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 12.0),
                    child: Container(
                      color: Colors.grey[600],
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 40,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Enn Enn no'),
                                Text('Shuboutai'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 12.0),
                    child: Container(
                      color: Colors.grey[600],
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 40,
                            color: Colors.red,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Enn Enn no'),
                                Text('Shuboutai'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              PageOneHorizontalList(title: 'Latest Releases', list: _demoItems,),
              PageOneHorizontalList(title: 'Trending', list: _demoItems,),
              PageOneHorizontalList(title: 'Genre', list: _demoItems,),
            ],
          ),
        ),
      ),
    );
  }
}
