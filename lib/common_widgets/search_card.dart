import 'package:anime_downloader/common_widgets/text_widget.dart';
import 'package:anime_downloader/screens/home/desc_screen.dart';
import 'package:flutter/material.dart';

Widget SearchCard(BuildContext context,
    {String title, String releaseDate, String imgUrl, String link}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: GestureDetector(
      child: Card(
        shadowColor: Colors.grey,
        elevation: 8,
        child: Container(
          child: Column(
            children: [
              Flexible(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextWidget(
                        title: 'Name',
                        input: title,
                        type: 'searchScreen',
                      ),
                      TextWidget(
                        title: 'Release',
                        input: releaseDate,
                        type: 'searchScreen',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DescriptionScreen(
            link: link,
            imageUrl: imgUrl,
          ),
        ),
      ),
    ),
  );
}
