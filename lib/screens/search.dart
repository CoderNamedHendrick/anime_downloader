import 'package:anime_downloader/screens/search_screen.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.headline1,
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                  search: _controller.value.text,
                ),
              ),
            ),
            iconSize: 32,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Color(0xff282828).withOpacity(0.01),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                  fillColor: Colors.orangeAccent,
                  hintText: 'Movies, Series or Genre',
                  hintStyle: Theme.of(context).textTheme.bodyText1),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
