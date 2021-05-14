import 'package:anime_downloader/common_widgets/text_widget.dart';
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
                  flex: 6,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TextWidget(
                    title: 'Name',
                    input: 'World Trigger',
                    type: 'searchScreen',
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TextWidget(
                    title: 'Release',
                    input: '2019',
                    type: 'searchScreen',
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () => Navigator.pushNamed(context, '/description'),
      ),
    );
  }
}


