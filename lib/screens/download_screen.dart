import 'package:flutter/material.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download links'),
      ),
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
    title: Text('Download ##'),
    trailing: Icon(Icons.download_outlined),
    onTap: () => null,
  );
}
