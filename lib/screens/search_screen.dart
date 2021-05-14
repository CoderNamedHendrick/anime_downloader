import 'package:anime_downloader/blocs/search_bloc.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/common_widgets/search_card.dart';
import 'package:anime_downloader/model/search_model.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key, @required this.search}) : super(key: key);
  final String search;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SearchBloc(name: widget.search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchSearchList(name: widget.search),
        child: StreamBuilder<ApiResponse<List<SearchModel>>>(
          stream: _bloc.searchListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
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
    return GridView.builder(
      itemCount: searchList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemBuilder: (context, index) {
        return SearchCard(
          context,
          title: searchList[index].name,
          releaseDate: searchList[index].release,
          imgUrl: searchList[index].image,
          link: searchList[index].link,
        );
      },
    );
  }
}


