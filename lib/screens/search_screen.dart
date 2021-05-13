import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Result'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                _searchCard(context),
                _searchCard(context),
              ],
            ),
            Row(
              children: [
                _searchCard(context),
                _searchCard(context),
              ],
            ),
            Row(
              children: [
                _searchCard(context),
                _searchCard(context),
              ],
            ),
            Row(
              children: [
                _searchCard(context),
                _searchCard(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        child: Card(
          shadowColor: Colors.grey,
          elevation: 8,
          child: Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 2.3,
            child: Column(
              children: [
                Flexible(
                  flex: 7,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    "Name : World Trigger",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    "Release: 2019",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () => Navigator.pushNamed(context, '/description'),
      ),
    );
  }
}
