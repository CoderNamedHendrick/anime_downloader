import 'package:anime_downloader/blocs/description_bloc.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/common_widgets/text_widget.dart';
import 'package:anime_downloader/model/description_model.dart';
import 'package:anime_downloader/screens/episodes_screen.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({Key key, this.link, this.imageUrl})
      : super(key: key);
  final String link;
  final String imageUrl;

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  DescriptionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = DescriptionBloc(link: widget.link);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.link);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchDescription(link: widget.link),
        child: StreamBuilder<ApiResponse<DescriptionModel>>(
          stream: _bloc.descriptionStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return Description(
                    desc: snapshot.data.data,
                    imageUrl: widget.imageUrl,
                  );
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () =>
                        _bloc.fetchDescription(link: widget.link),
                  );
                  break;
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
  const Description({Key key, this.desc, this.imageUrl}) : super(key: key);
  final DescriptionModel desc;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          expandedHeight: MediaQuery.of(context).size.height / 2.5,
          flexibleSpace: FlexibleSpaceBar(
            background: Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            // stretchModes: [
            //   StretchMode.zoomBackground,
            //   // StretchMode.blurBackground,
            // ],
          ),
          title: Text(
            'Preview',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SliverFillRemaining(
          child: Container(
            color: Colors.red,
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstCharacterUpper(desc.name),
                    style: Theme.of(context).textTheme.headline1,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Center(
                              child: Text(
                            'R',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
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
                    height: MediaQuery.of(context).size.height / 14.7,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_downward_rounded),
                          Text('Download')
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EpisodesScreen(
                            start: desc.episodeStart,
                            end: desc.episodeEnd,
                            id: desc.id,
                            name: desc.name,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  // TextWidget(
                  //   title: 'Name',
                  //   input: desc.name,
                  //   type: 'descriptionScreen',
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // TextWidget(
                  //   title: 'Type',
                  //   input: desc.type,
                  //   type: 'descriptionScreen',
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // TextWidget(
                  //   title: 'Summary',
                  //   input: desc.summary,
                  //   type: 'descriptionScreen',
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // TextWidget(
                  //   title: 'Genre',
                  //   input: desc.genre,
                  //   type: 'descriptionScreen',
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // TextWidget(
                  //   title: 'Release',
                  //   input: desc.release,
                  //   type: 'descriptionScreen',
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // TextWidget(
                  //   title: 'Status',
                  //   input: desc.status,
                  //   type: 'descriptionScreen',
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // TextWidget(
                  //   title: 'OtherNames',
                  //   input: desc.otherNames,
                  //   type: 'descriptionScreen',
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
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
                            "start: " + desc.episodeStart,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "end: " + desc.episodeEnd,
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
    );
  }
}

String firstCharacterUpper(String text) {
  List arrayPieces = List();

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
