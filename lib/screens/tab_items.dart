import 'package:flutter/material.dart';

enum TabItem { HOME, SEARCH, LIBRARY }

class TabItemData {
  const TabItemData({required this.title, required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.HOME: TabItemData(title: "Home", icon: Icons.home_outlined),
    TabItem.SEARCH: TabItemData(title: "Search", icon: Icons.search),
  };
}
