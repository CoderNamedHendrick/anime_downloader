import 'package:flutter/material.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) => _episodes(),
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}

Widget _episodes() {
  return ListTile(
    title: Text('Episode ##'),
    trailing: Icon(Icons.chevron_right),
    onTap: () => null,
  );
}
