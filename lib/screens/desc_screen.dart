import 'package:anime_downloader/blocs/description_bloc.dart';
import 'package:anime_downloader/common_widgets/loading_widget.dart';
import 'package:anime_downloader/common_widgets/text_widget.dart';
import 'package:anime_downloader/model/description_model.dart';
import 'package:anime_downloader/services/api_response.dart';
import 'package:anime_downloader/common_widgets/error_widget.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({Key key, this.link}) : super(key: key);
  final String link;

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
          builder: (conttext, snapshot) {
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
}

class Description extends StatelessWidget {
  const Description({Key key, this.desc}) : super(key: key);
  final DescriptionModel desc;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                    input: desc.name,
                    type: 'descriptionScreen',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    title: 'Type',
                    input: desc.type,
                    type: 'descriptionScreen',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    title: 'Summary',
                    input: desc.summary,
                    type: 'descriptionScreen',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    title: 'Genre',
                    input: desc.genre,
                    type: 'descriptionScreen',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    title: 'Release',
                    input: desc.release,
                    type: 'descriptionScreen',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    title: 'Status',
                    input: desc.status,
                    type: 'descriptionScreen',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    title: 'OtherNames',
                    input: desc.otherNames,
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
