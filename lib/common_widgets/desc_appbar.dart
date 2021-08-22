import 'package:anime_downloader/services/auth.dart';
import 'package:anime_downloader/services/database.dart';
import 'package:anime_downloader/services/firebase_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key key,
    @required this.size2,
    @required this.imgUrl,
    @required this.link,
    @required this.textTheme2,
  }) : super(key: key);

  final Size size2;
  final String imgUrl;
  final String link;
  final TextTheme textTheme2;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        final user = snapshot.data;
        return SliverAppBar(
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          expandedHeight: widget.size2.height / 2.5,
          flexibleSpace: FlexibleSpaceBar(
            background: Image(
              image: NetworkImage(widget.imgUrl),
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            'Preview',
            style: widget.textTheme2.headline1,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save_rounded),
              onPressed: () {
                FirestoreDatabase(uid: user.uid, email: user.email)
                    .addFavourite(
                  FavouriteModel(img: widget.imgUrl, link: widget.link),
                );
                setState(
                  () {
                    SnackBar snackBar = SnackBar(
                      content: Text('Saved'),
                      duration: Duration(milliseconds: 600),
                      elevation: 8,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
