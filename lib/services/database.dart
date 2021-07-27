import 'package:anime_downloader/services/firebase_model.dart';
import 'package:anime_downloader/services/firestore_path.dart';
import 'package:anime_downloader/services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class Database {
  Future<void> setFavourite(FavouriteModel favourite);
  Future<void> addFavourite(FavouriteModel favourite);
  Future<void> deleteFavourite(FavouriteModel favourite);
  Stream<List<FavouriteModel>> favouriteStream({@required String favouriteId});
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid, @required this.email});
  final String uid;
  final String email;
  final _service = FirestoreService.instance;

  @override
  Future<void> setFavourite(FavouriteModel favourite) {
    _service.setData(
        path: FireStorePath.favourites(uid),
        data: favourite.toMap(),
        email: email,
        uid: uid);
  }

  @override
  Future<void> addFavourite(FavouriteModel favourite) => _service.addFavourite(
        path: FireStorePath.favourites(uid),
        data: favourite.toMap(),
      );

  @override
  Future<void> deleteFavourite(FavouriteModel favourite) =>
      _service.deleteFavourite(
        path: FireStorePath.favourites(uid),
        data: favourite.toMap(),
      );
  @override
  Stream<List<FavouriteModel>> favouriteStream({String favouriteId}) {
    return _service.favouriteStream(
        path: FireStorePath.favourites(uid),
        builder: (data) => FavouriteModel.fromMap(data));
  }
}
