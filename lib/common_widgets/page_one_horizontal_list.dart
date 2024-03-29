import 'package:anime_downloader/screens/home/coming_soon.dart';
import 'package:anime_downloader/screens/home/desc_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class PopularHorizontalList extends StatelessWidget {
  const PopularHorizontalList({required this.title, required this.list});
  final String title;
  final List list;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: 12),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: EdgeInsets.zero,
              child: ListView.separated(
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 8.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 180,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(list[index].image),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          AutoSizeText(
                            '${list[index].name}',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    onTap: () => DescriptionScreen.show(
                      context,
                      link: list[index].link,
                      imageUrl: list[index].image,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PopularHorizontalListSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonAnimation(
            child: Container(
              height: 26,
              width: MediaQuery.of(context).size.width / 2.3,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 12),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: EdgeInsets.zero,
              child: ListView.separated(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 8.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    width: 140,
                    child: Column(
                      children: [
                        SkeletonAnimation(
                          child: Container(
                            height: 180,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SkeletonAnimation(
                          child: Container(
                            height: 16,
                            width: 120,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LatestHorizontalList extends StatelessWidget {
  const LatestHorizontalList({required this.title, required this.list});
  final String title;
  final List list;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: 12),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: EdgeInsets.zero,
              child: ListView.separated(
                itemCount: list.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 8.0,
                ),
                itemBuilder: (context, index) {
                  var textTheme2 = Theme.of(context).textTheme;
                  return GestureDetector(
                    child: Container(
                      width: 140,
                      child: Column(children: [
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(list[index].image),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        AutoSizeText(
                          '${list[index].name}',
                          maxLines: 1,
                          style: textTheme2.bodyText1,
                        ),
                        SizedBox(height: 6),
                        Text(
                          '${list[index].episode}',
                          style: textTheme2.bodyText1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ComingSoon(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LatestHorizontalListSkeleton extends StatelessWidget {
  const LatestHorizontalListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonAnimation(
            child: Container(
              height: 26,
              width: MediaQuery.of(context).size.width / 2.3,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 12),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: EdgeInsets.zero,
              child: ListView.separated(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 8.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    width: 140,
                    child: Column(
                      children: [
                        SkeletonAnimation(
                          child: Container(
                            height: 180,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 4),
                        SkeletonAnimation(
                          child: Container(
                            height: 16,
                            width: 120,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 6),
                        SkeletonAnimation(
                          child: Container(
                            height: 16,
                            width: 120,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
