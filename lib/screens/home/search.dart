import 'dart:async';

import 'package:anime_downloader/blocs/genres_bloc.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/common_widgets/search_history_tile.dart';
import 'package:anime_downloader/model/box.dart';
import 'package:anime_downloader/model/name_link.dart';
import 'package:anime_downloader/model/recent_search.dart';
import 'package:anime_downloader/screens/home/desc_screen.dart';
import 'package:anime_downloader/screens/home/search_screen.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CheckHistoryBloc {
  StreamController<bool> _controller = StreamController<bool>();
  Stream<bool> get toHistroyStream => _controller.stream;

  void toSearchHistory(bool toSearchHistory) {
    _controller.add(toSearchHistory);
  }

  void dispose() {
    _controller.close();
  }
}

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  GenresBloc _bloc;
  CheckHistoryBloc _historyBloc;
  TextEditingController _controller = TextEditingController();
  bool searchHistory = false;

  @override
  void initState() {
    super.initState();
    _bloc = GenresBloc();
    _historyBloc = CheckHistoryBloc();
    _historyBloc.toSearchHistory(searchHistory);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme2 = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: textTheme2.headline1,
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.youtube_searched_for_sharp),
            onPressed: () {
              searchHistory = !searchHistory;
              _historyBloc.toSearchHistory(searchHistory);
              setState(() {});
            },
            iconSize: 32,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: StreamBuilder<bool>(
              stream: _historyBloc.toHistroyStream,
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _controller,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                              fillColor: Colors.orangeAccent,
                              hintText: 'Movies, Series or Genre',
                              hintStyle: textTheme2.bodyText1),
                          style: textTheme2.bodyText1,
                          onEditingComplete: () => SearchScreen.show(
                            context,
                            _controller.value.text,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      snapshot.data == true ? 'Search History' : 'By Genre',
                      style: textTheme2.headline1,
                    ),
                    SizedBox(height: 6),
                    snapshot.data == true ? _searchHistory() : _searchGenre(),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget _searchGenre() {
    return RefreshIndicator(
      onRefresh: () => _bloc.fetchGenres(),
      child: StreamBuilder<ApiResponse<List<NameLinkModel>>>(
        stream: _bloc.genresStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(
                  loadingMessage: snapshot.data.message,
                );
                break;
              case Status.COMPLETED:
                return Genres(
                  list: snapshot.data.data,
                );
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => _bloc.fetchGenres(),
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget _searchHistory() {
    return ValueListenableBuilder<Box<RecentSearch>>(
      valueListenable: Boxes.getRecentSearches().listenable(),
      builder: (context, box, _) {
        final boxList = box.values.toList().cast<RecentSearch>();
        return ListView.builder(
          itemCount: boxList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SearchHistoryTile(
              onTap: () => DescriptionScreen.show(context,
                  link: boxList[index].link, imageUrl: boxList[index].imgUrl),
              title: boxList[index].title,
              imgUrl: boxList[index].imgUrl,
              trailing: IconButton(
                onPressed: () {
                  deleteRecent(boxList[index]);
                  setState(() {});
                },
                icon: FaIcon(FontAwesomeIcons.times, color: Colors.white),
              ),
            );
          },
        );
      },
    );
  }

  void deleteRecent(RecentSearch recentSearch) {
    recentSearch.delete();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _historyBloc.dispose();
  }
}

class Genres extends StatelessWidget {
  final List list;
  const Genres({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> genres() {
      List<Widget> _chips = List(list.length);
      for (int index = 0; index < list.length; index++) {
        print(list[index]);
        _chips[index] = Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: ActionChip(
            label: Text(list[index].name),
            labelStyle: TextStyle(fontSize: 18),
            elevation: 4,
            onPressed: () => SearchScreen.show(
              context,
              list[index].link,
            ),
            // onPressed: () => Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => SearchScreen(
            //       search: list[index].link,
            //     ),
            //   ),
            // ),
          ),
        );
      }
      return _chips;
    }

    return Wrap(
      children: genres(),
    );
  }
}

// class Genres extends StatelessWidget {
//   final List list;
//   const Genres({this.list, Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//       child: Container(
//         height: MediaQuery.of(context).size.height - 40,
//         child: GridView.builder(
//           itemCount: list.length,
//           scrollDirection: Axis.vertical,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               childAspectRatio: 0.6, crossAxisCount: 2),
//           itemBuilder: (context, index) => GestureDetector(
//             child: Card(
//               color: Theme.of(context).accentColor,
//               child: Container(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       flex: 1,
//                       child: Container(
//                         color: Colors.red,
//                       ),
//                     ),
//                     Flexible(
//                       flex: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text('${list[index].name}'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             onTap: () => Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => SearchScreen(
//                 search: list[index].link,
//               ),
//             )),
//           ),
//         ),
//       ),
//     );
//   }
// }
