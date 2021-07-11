import 'package:anime_downloader/blocs/latest_bloc.dart';
import 'package:anime_downloader/blocs/popular_bloc.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/common_widgets/page_one_horizontal_list.dart';
import 'package:anime_downloader/common_widgets/recent_searches_widget.dart';
import 'package:anime_downloader/common_widgets/show_alert_dialog.dart';
import 'package:anime_downloader/model/latest_model.dart';
import 'package:anime_downloader/model/popular_model.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:anime_downloader/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _bottomModalAnimController;
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you sure you want to logout?',
        defaultActionText: 'Logout',
        cancelActionText: 'Cancel');
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  PopularBloc _bloc;
  LatestAnimeBloc _latestAnimeBloc;

  @override
  void initState() {
    super.initState();
    _bloc = PopularBloc();
    _latestAnimeBloc = LatestAnimeBloc();
    _bottomModalAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
      reverseDuration: Duration(milliseconds: 520),
    );
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
        actions: [
          TextButton(
            child: Text(
              "Sign-in",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onPressed: () {
              _showBottomModal(context);
            },
          ),
          // TextButton(
          //   child: Text(
          //     'Logout',
          //     style: Theme.of(context).textTheme.bodyText1,
          //   ),
          //   onPressed: () => _confirmSignOut(context),
          // ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
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
                            return Loading(
                                loadingMessage: snapshot.data.message);
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
                SizedBox(height: 4),
                RefreshIndicator(
                  onRefresh: () => _bloc.fetchPopular(),
                  child: StreamBuilder<ApiResponse<List<PopularModel>>>(
                    stream: _bloc.popularStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            return Loading(
                                loadingMessage: snapshot.data.message);
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
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  _showBottomModal(context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      transitionAnimationController: _bottomModalAnimController,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height / 3,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                ),
              ],
            ),
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign In options",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(
                  height: 14,
                ),
                Align(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "images/google-logo.png",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
