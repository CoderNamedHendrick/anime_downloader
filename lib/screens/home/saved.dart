import 'package:anime_downloader/common_widgets/show_alert_dialog.dart';
import 'package:anime_downloader/screens/home/desc_screen.dart';
import 'package:anime_downloader/services/auth.dart';
import 'package:anime_downloader/services/database.dart';
import 'package:anime_downloader/services/firebase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text('Saved Animes'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SavedBuild(),
      ),
    );
  }
}

class SavedBuild extends StatefulWidget {
  const SavedBuild({super.key});

  @override
  _SavedBuildState createState() => _SavedBuildState();
}

class _SavedBuildState extends State<SavedBuild> {
  Future<void> _deleteSavedAnime(
    BuildContext context, {
    required String title,
    required FirestoreDatabase database,
    required FavouriteModel favourite,
  }) async {
    final didRequestDelete = await showAlertDialog(
      context,
      title: 'Delete saved anime',
      content: 'Are you sure you want to delete $title from your saved animes?',
      defaultActionText: 'yes',
      cancelActionText: 'no',
    );

    if (didRequestDelete == true) {
      await database.deleteSaved(favourite);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<AuthBase>(context, listen: false).currentUser;
    final database = FirestoreDatabase(
      uid: user?.uid ?? '',
      email: user?.email ?? '',
    );
    return StreamBuilder<DocumentSnapshot>(
      stream: database.savedStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        if (snapshot.hasData) {
          final savedList = snapshot.data?.get('saved');
          return savedList.length == 0
              ? Center(
                  child: Text(
                    "No Saved Animes...",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              : GridView.builder(
                  itemCount: savedList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => DescriptionScreen.show(
                        context,
                        link: savedList[index]['link'],
                        imageUrl: savedList[index]['img'],
                      ),
                      onLongPress: () async => await _deleteSavedAnime(
                        context,
                        title:
                            '${savedList[index]['link'].replaceAll("/category/", "")}',
                        database: database,
                        favourite: FavouriteModel(
                          img: savedList[index]['img'],
                          link: savedList[index]['link'],
                        ),
                      ),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Container(
                                height: 150,
                                width: 125,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "${savedList[index]['img']}"),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  '${savedList[index]['link'].replaceAll("/category/", "")}',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
        }
        return Container();
      },
    );
  }
}
