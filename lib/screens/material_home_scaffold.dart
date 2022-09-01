import 'package:anime_downloader/screens/tab_items.dart';
import 'package:flutter/material.dart';

class MaterialHomeScaffold extends StatelessWidget {
  const MaterialHomeScaffold({
    super.key,
    required this.currentTab,
    required this.onSelectTab,
    required this.navigatorKeys,
    required this.widgetBuilders,
  });

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentTab.index,
        children: [
          Builder(
            builder: widgetBuilders[TabItem.values[0]]!,
          ),
          Builder(
            builder: widgetBuilders[TabItem.values[1]]!,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _buildItem(TabItem.HOME),
          _buildItem(TabItem.SEARCH),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 6,
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.white : Colors.grey[500];
    final iconSize = currentTab == tabItem ? 28.0 : 18.0;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData?.icon,
        color: color,
        size: iconSize,
      ),
      label: itemData?.title,
    );
  }
}
