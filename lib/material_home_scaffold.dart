import 'package:anime_downloader/tab_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialHomeScaffold extends StatelessWidget {
  const MaterialHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.navigatorKeys,
    @required this.widgetBuilders,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.HOME),
          _buildItem(TabItem.SEARCH),
          _buildItem(TabItem.LIBRARY),
        ],
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (context) => widgetBuilders[item](context),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.white : Colors.grey[500];
    final iconSize = currentTab == tabItem ? 32.0 : 20.0;
    final textSize = currentTab == tabItem ? 16.0 : 12.0;
    return BottomNavigationBarItem(
        icon: Icon(
          itemData.icon,
          color: color,
          size: iconSize,
        ),
        title: Text(
          itemData.title,
          style: TextStyle(
            color: color,
            fontSize: textSize,
          ),
        ));
  }
}
