import 'package:anime_downloader/common_widgets/horizontal_list_view.dart';
import 'package:flutter/material.dart';

Widget PageOneHorizontalList({String title, List list}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 12),
        Expanded(
          child: Container(
            padding: EdgeInsets.zero,
            child: ListView.separated(
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                      width: 8.0,
                    ),
                itemBuilder: (context, index) {
                  return Container(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 180,
                          color: Colors.green,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Demon Slayer Mugen Train'),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ],
    ),
  );
}