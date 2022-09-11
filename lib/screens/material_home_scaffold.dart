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
        currentIndex: currentTab.index,
        onTap: (index) => onSelectTab(TabItem.values[index]),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey[500], size: 18,
        ),
        selectedIconTheme: IconThemeData(
          color: Colors.white, size: 28,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: TextStyle(
          color: Colors.white,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.grey[500],
        ),
        elevation: 6,
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(
        itemData?.icon,
      ),
      label: itemData?.title,
    );
  }
}
