import 'package:anime_downloader/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height / 2.5,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: AssetImage('images/rectangle.png'),
              ),
              stretchModes: [
                // StretchMode.zoomBackground,
                // StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
            ),
            actions: [
              IconButton(
                iconSize: 42,
                icon: Icon(Icons.arrow_circle_down_sharp),
                onPressed: () => Navigator.of(context).pushNamed('/episodes'),
              ),
            ],
          ),
          SliverFillRemaining(
            child: Container(
              color: Colors.red,
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      title: 'Name',
                      input: 'World-trigger-dub',
                      type: 'descriptionScreen',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextWidget(
                      title: 'Type',
                      input: 'Fall 2014 Anime',
                      type: 'descriptionScreen',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextWidget(
                      title: 'Summary',
                      input:
                          "When a gate to another world suddenly opens on Earth, Mikado City is invaded by strange creatures known as \"Neighbors,\" malicious beings impervious to traditional weaponry. In response to their arrival, an organization called the Border Defense Agency has been established to combat the Neighbor menace through special weapons called \"Triggers.\" Even though several years have passed after the gate first opened, Neighbors are still a threat and members of Border remain on guard to ensure the safety of the planet.\n\nDespite this delicate situation, members-in-training, such as Osamu Mikumo, are not permitted to use their Triggers outside of headquarters. But when the mysterious new student in his class is dragged into a forbidden area by bullies, they are attacked by Neighbors, and Osamu has no choice but to do what he believes is right. Much to his surprise, however, the transfer student Yuuma Kuga makes short work of the aliens, revealing that he is a humanoid Neighbor in disguise.\nNoted",
                      type: 'descriptionScreen',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextWidget(
                      title: 'Genre',
                      input: "Action, School, Sci-Fi, Shounen, Supernatural",
                      type: 'descriptionScreen',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextWidget(
                      title: 'Release',
                      input: "2014",
                      type: 'descriptionScreen',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextWidget(
                      title: 'Status',
                      input: "Completed",
                      type: 'descriptionScreen',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextWidget(
                      title: 'OtherNames',
                      input: "ワールドトリガー",
                      type: 'descriptionScreen',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Episodes:",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "start: 0",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "end: 73",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
