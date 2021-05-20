import 'package:flutter/material.dart';

Widget RecentSearchWidget() {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 12.0),
        child: Container(
          color: Colors.grey[600],
          child: Row(
            children: [
              Container(
                height: 50,
                width: 40,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Enn Enn no'),
                    Text('Shuboutai'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 12.0),
        child: Container(
          color: Colors.grey[600],
          child: Row(
            children: [
              Container(
                height: 50,
                width: 40,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Enn Enn no'),
                    Text('Shuboutai'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
