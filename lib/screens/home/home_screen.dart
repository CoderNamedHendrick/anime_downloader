import 'package:anime_downloader/screens/home/home_page.dart';
import 'package:anime_downloader/screens/home/library_screen.dart';
import 'package:anime_downloader/screens/home/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const List<Widget> _navBarWidgets = [
    HomePage(),
    Search(),
    LibraryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _navBarWidgets,
        index: _selectedIndex,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            tooltip: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_outlined),
            label: 'Library',
            tooltip: 'Library',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 32),
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).accentColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
