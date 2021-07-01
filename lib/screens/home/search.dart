import 'package:anime_downloader/blocs/genres_bloc.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/model/name_link_model.dart';
import 'package:anime_downloader/screens/home/search_screen.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  GenresBloc _bloc;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = GenresBloc();
  }

  @override
  Widget build(BuildContext context) {
    _search() => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchScreen(
              search: _controller.value.text,
            ),
          ),
        );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.headline1,
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.saved_search),
            onPressed: () => null,
            iconSize: 32,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                        fillColor: Colors.orangeAccent,
                        hintText: 'Movies, Series or Genre',
                        hintStyle: Theme.of(context).textTheme.bodyText1),
                    style: Theme.of(context).textTheme.bodyText1,
                    onEditingComplete: _search,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'By Genre',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 6),
              RefreshIndicator(
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
              ),
              SizedBox(
                height: 6,
              ),
              // Text(
              //   'By Release Year',
              //   style: Theme.of(context).textTheme.headline1,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              //   child: Container(
              //     height: MediaQuery.of(context).size.height / 3.2,
              //     child: GridView.builder(
              //       itemCount: 10,
              //       scrollDirection: Axis.vertical,
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           childAspectRatio: 0.6, crossAxisCount: 2),
              //       itemBuilder: (context, index) => Card(
              //         color: Colors.grey,
              //         child: Container(
              //           child: Row(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Flexible(
              //                 flex: 1,
              //                 child: Container(
              //                   color: Colors.red,
              //                 ),
              //               ),
              //               Flexible(
              //                 flex: 2,
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text('Dummy Text'),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
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
              labelStyle: TextStyle(fontSize: 20),
              elevation: 4,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    search: list[index].link,
                  ),
                ),
              ),
            ));
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
