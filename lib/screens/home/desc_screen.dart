import 'package:anime_downloader/blocs/description_bloc.dart';
import 'package:anime_downloader/common_widgets/bottom_modal.dart';
import 'package:anime_downloader/common_widgets/desc_appbar.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/model/description.dart';
import 'package:anime_downloader/screens/home/coming_soon.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:anime_downloader/services/database.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({
    Key? key,
    required this.link,
    required this.imageUrl,
  }) : super(key: key);
  final String link;
  final String imageUrl;

  static void show(BuildContext context,
      {required String link,
      required String imageUrl,
      Database? database}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DescriptionScreen(
          link: link,
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  late DescriptionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = DescriptionBloc(link: widget.link);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.link);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchDescription(link: widget.link),
        child: StreamBuilder<ApiResponse<DescriptionModel>>(
          stream: _bloc.descriptionStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data!.message,
                  );
                case Status.COMPLETED:
                  return Description(
                    desc: snapshot.data!.data,
                    imageUrl: widget.imageUrl,
                    link: widget.link,
                  );
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data!.message,
                    onRetryPressed: () =>
                        _bloc.fetchDescription(link: widget.link),
                  );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class Description extends StatelessWidget {
  const Description(
      {super.key,
      required this.desc,
      required this.imageUrl,
      required this.link});
  final DescriptionModel desc;
  final String imageUrl;
  final String link;

  @override
  Widget build(BuildContext context) {
    var size2 = MediaQuery.of(context).size;
    var textTheme2 = Theme.of(context).textTheme;
    return CustomScrollView(
      slivers: <Widget>[
        CustomAppBar(
            size2: size2, imgUrl: imageUrl, link: link, textTheme2: textTheme2),
        SliverFillRemaining(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstCharacterUpper(desc.name),
                    style: textTheme2.headline1,
                  ),
                  SizedBox(height: 6),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 25,
                          height: 22,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Center(
                            child: Text(
                              'R',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            desc.release,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    desc.genre,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 6),
                  SizedBox(
                    height: size2.height / 14.7,
                    width: size2.width,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            'Download',
                            style: textTheme2.bodyText1,
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      onPressed: () => desc.status != 'Upcoming'
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ComingSoon()),
                            )
                          : Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    desc.summary,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Episodes:",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "start: " + desc.episodeStart,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "end: " + desc.episodeEnd,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
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
    );
  }
}

showBottomModal(context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return AppBottomModal.create(context);
    },
  );
}

String firstCharacterUpper(String text) {
  List arrayPieces = [];

  String outPut = '';
  text.split(' ').forEach((separatedWord) {
    arrayPieces.add(separatedWord);
  });

  arrayPieces.forEach((word) {
    word =
        "${word[0].toString().toUpperCase()}${word.toString().substring(1)} ";
    outPut += word;
  });

  return outPut;
}
