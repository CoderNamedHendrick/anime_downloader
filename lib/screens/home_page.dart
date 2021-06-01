import 'dart:ffi';

import 'package:anime_downloader/blocs/latest_bloc.dart';
import 'package:anime_downloader/blocs/popular_bloc.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/common_widgets/page_one_horizontal_list.dart';
import 'package:anime_downloader/common_widgets/recent_searches_widget.dart';
import 'package:anime_downloader/model/latest_model.dart';
import 'package:anime_downloader/model/popular_model.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PopularBloc _bloc;
  LatestAnimeBloc _latestAnimeBloc;
  List _demoItems = ['One', 'Two', 'Three', 'Four', 'Five', 'Six'];

  @override
  void initState() {
    super.initState();
    _bloc = PopularBloc();
    _latestAnimeBloc = LatestAnimeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recent Searches',
          style: Theme.of(context).textTheme.headline1,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      RecentSearch(),
                      RecentSearch(),
                    ],
                  ),
                  Row(
                    children: [
                      RecentSearch(),
                      RecentSearch(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
              RefreshIndicator(
                onRefresh: () => _latestAnimeBloc.fetchLatest(),
                child: StreamBuilder<ApiResponse<List<LatestAnimeModel>>>(
                  stream: _latestAnimeBloc.latestStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(loadingMessage: snapshot.data.message);
                          break;
                        case Status.COMPLETED:
                          return Container(
                            height: 330,
                            child: LatestHorizontalList(
                              title: 'Latest',
                              list: snapshot.data.data,
                            ),
                          );
                          break;
                        case Status.ERROR:
                          return Error(
                            errorMessage: snapshot.data.message,
                            onRetryPressed: () =>
                                _latestAnimeBloc.fetchLatest(),
                          );
                          break;
                      }
                    }
                    return Container();
                  },
                ),
              ),
              SizedBox(height: 12),
              RefreshIndicator(
                onRefresh: () => _bloc.fetchPopular(),
                child: StreamBuilder<ApiResponse<List<PopularModel>>>(
                  stream: _bloc.popularStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(loadingMessage: snapshot.data.message);
                          break;
                        case Status.COMPLETED:
                          return Container(
                            height: 330,
                            child: PopularHorizontalList(
                              title: 'Trending',
                              list: snapshot.data.data,
                            ),
                          );
                          break;
                        case Status.ERROR:
                          return Error(
                            errorMessage: snapshot.data.message,
                            onRetryPressed: () => _bloc.fetchPopular(),
                          );
                          break;
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
