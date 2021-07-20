import 'package:anime_downloader/tab_items.dart';
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
    return Scaffold(
      body: Builder(
        builder: (context) {
          return widgetBuilders[TabItem.values[currentTab.index]](context);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildItem(TabItem.HOME),
          _buildItem(TabItem.SEARCH),
          _buildItem(TabItem.LIBRARY),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.white : Colors.grey[500];
    final iconSize = currentTab == tabItem ? 28.0 : 18.0;
    final textSize = currentTab == tabItem ? 12.0 : 10.0;
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
      ),
    );
  }
}
