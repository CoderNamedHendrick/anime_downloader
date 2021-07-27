import 'package:anime_downloader/blocs/search_bloc.dart';
import 'package:anime_downloader/blocs/search_by_genre_bloc.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:anime_downloader/common_widgets/search_card.dart';
import 'package:anime_downloader/model/search.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key, @required this.search}) : super(key: key);
  final String search;

  static Future<void> show(BuildContext context, String link) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchScreen(
          search: link,
        ),
      ),
    );
  }

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _bloc;

  @override
  void initState() {
    super.initState();
    print(widget.search);
    if (widget.search.contains("/")) {
      _bloc = SearchByGenreBloc(name: widget.search);
    } else {
      _bloc = SearchBloc(name: widget.search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchSearchList(name: widget.search),
        child: StreamBuilder<ApiResponse<List<SearchModel>>>(
          stream: _bloc.searchListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return SearchListSkeleton();
                  break;
                case Status.COMPLETED:
                  return SearchList(
                    searchList: snapshot.data.data,
                  );
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () =>
                        _bloc.fetchSearchList(name: widget.search),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class SearchList extends StatelessWidget {
  const SearchList({Key key, this.searchList}) : super(key: key);
  final List<SearchModel> searchList;

  @override
  Widget build(BuildContext context) {
    print(searchList.length);
    return searchList.length == 0
        ? GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Theme.of(context).primaryColor,
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Text(
                  'No results found, probably a spelling mistake?',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          )
        : GridView.builder(
            itemCount: searchList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemBuilder: (context, index) {
              return SearchCard(
                title: searchList[index].name,
                releaseDate: searchList[index].release,
                imgUrl: searchList[index].image,
                link: searchList[index].link,
              );
            },
          );
  }
}

class SearchListSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemBuilder: (context, index) {
        return SearchCardSkeleton();
      },
    );
  }
}
