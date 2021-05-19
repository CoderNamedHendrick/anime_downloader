import 'package:flutter/material.dart';

Widget HorizontalListView(List list) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.zero,
      child: ListView.separated(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) =>
              SizedBox(
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
  );
}