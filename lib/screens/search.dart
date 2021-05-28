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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
              SizedBox(
                height: 6,
              ),
              Text(
                'By Genre',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  child: GridView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.6,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) => Card(
                      color: Colors.grey,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                color: Colors.red,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Dummy Text'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'By Release Year',
                style: Theme.of(context).textTheme.headline1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  child: GridView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.6,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) => Card(
                      color: Colors.grey,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                color: Colors.red,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Dummy Text'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
