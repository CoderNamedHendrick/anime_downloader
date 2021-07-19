import 'package:anime_downloader/blocs/latest_bloc.dart';
import 'package:anime_downloader/blocs/popular_bloc.dart';
import 'package:anime_downloader/common_widgets/bottom_modal.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:anime_downloader/common_widgets/page_one_horizontal_list.dart';
import 'package:anime_downloader/common_widgets/recent_searches_widget.dart';
import 'package:anime_downloader/common_widgets/show_alert_dialog.dart';
import 'package:anime_downloader/model/latest_model.dart';
import 'package:anime_downloader/model/popular_model.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:anime_downloader/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _height;
  bool isLoading = false;
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
      await _signOut(context);
    }
  }

  PopularBloc _bloc;
  LatestAnimeBloc _latestAnimeBloc;

  @override
  void initState() {
    super.initState();
    _bloc = PopularBloc();
    _latestAnimeBloc = LatestAnimeBloc();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    var textTheme2 = Theme.of(context).textTheme;
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.authStateChanges,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Recent Searches',
                style: textTheme2.headline1,
              ),
              elevation: 0,
              actions: [
                snapshot.data == null
                    ? TextButton(
                        child: Text(
                          "Sign-in",
                          style: textTheme2.bodyText1,
                        ),
                        onPressed: () async {
                          await _showBottomModal(context);
                          setState(() {});
                        },
                      )
                    : TextButton(
                        child: Text(
                          'Log Out',
                          style: textTheme2.bodyText1,
                        ),
                        onPressed: () async {
                          await _confirmSignOut(context);
                          setState(() {});
                        },
                      ),
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
                        child:
                            StreamBuilder<ApiResponse<List<LatestAnimeModel>>>(
                          stream: _latestAnimeBloc.latestStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              switch (snapshot.data.status) {
                                case Status.LOADING:
                                  // return Loading(
                                  //   loadingMessage: snapshot.data.message,
                                  // );
                                  return Container(
                                    height: _height / 2.7,
                                    child: LatestHorizontalListSkeleton(),
                                  );
                                  break;
                                case Status.COMPLETED:
                                  return LatestHorizontalList(
                                    title: 'Latest',
                                    list: snapshot.data.data,
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
                                  return Container(
                                    height: _height / 3,
                                    child: PopularHorizontalListSkeleton(),
                                  );
                                  break;
                                case Status.COMPLETED:
                                  return Container(
                                    height: _height / 3,
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
        });
  }

  _showBottomModal(context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AppBottomModal.create(context);
      },
    );
  }
}
