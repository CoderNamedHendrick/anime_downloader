import 'package:anime_downloader/common_widgets/horizontal_list_view.dart';
import 'package:flutter/material.dart';

Widget PageOneHorizontalList({String title, List list}){
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height: 12),
        HorizontalListView(list),
      ],
    ),
  );
}