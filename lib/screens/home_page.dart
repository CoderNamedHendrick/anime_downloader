import 'package:anime_downloader/screens/home/home.dart';
import 'package:anime_downloader/screens/home/search.dart';
import 'package:anime_downloader/screens/material_home_scaffold.dart';
import 'package:anime_downloader/screens/tab_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabItem _currentTab = TabItem.HOME;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.HOME: GlobalKey<NavigatorState>(),
    TabItem.SEARCH: GlobalKey<NavigatorState>(),
    TabItem.LIBRARY: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get _widgetBuilders {
    return {
      TabItem.HOME: (_) => Home(),
      TabItem.SEARCH: (_) => Search(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: MaterialHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        navigatorKeys: navigatorKeys,
        widgetBuilders: _widgetBuilders,
      ),
    );
  }
}
