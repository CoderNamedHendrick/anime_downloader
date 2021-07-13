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
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
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
                              height: _height / 3,
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
  }

  _showBottomModal(context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomModal();
      },
    );
  }
}

class BottomModal extends StatefulWidget {
  @override
  _BottomModalState createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      constraints: BoxConstraints(
        maxHeight: height / 3,
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
          children: [
            Text(
              "Sign In options",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              height: height / 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLoading = !isLoading;
                });
              },
              child: AnimatedCrossFade(
                duration: const Duration(seconds: 2),
                alignment: Alignment.center,
                firstChild: _signInOptions(),
                firstCurve: Curves.elasticIn,
                secondChild: Container(
                  height: 100,
                  width: 200,
                  child: Center(child: CircularProgressIndicator()),
                ),
                layoutBuilder: (Widget topChild, Key topChildKey,
                    Widget bottomChild, Key bottomChildKey) {
                  return Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Positioned(key: topChildKey, child: topChild),
                      Positioned(
                        key: bottomChildKey,
                        child: bottomChild,
                        left: 0,
                        right: 0,
                      ),
                    ],
                  );
                },
                crossFadeState: isLoading
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _signInOptions() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/twitter-logo.png'),
                  ),
                ),
              ),
              Text("Sign In with Twitter"),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/google-logo.png'),
                  ),
                ),
              ),
              Text("Sign In with Google"),
            ],
          ),
        ],
      ),
    );
  }
}

_method() {
  var height;
}
