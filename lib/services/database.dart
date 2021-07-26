import 'package:anime_downloader/services/firebase_model.dart';
import 'package:anime_downloader/services/firestore_path.dart';
import 'package:anime_downloader/services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class Database {
  Future<void> setFavourite(FavouriteModel favourite);
  Future<void> deleteFavourite(FavouriteModel favourite);
  Stream<FavouriteModel> favouriteStream({@required String favouriteId});
  Stream<List<FavouriteModel>> favouritesStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid});
  final String uid;
  final _service = FirestoreService.instance;


  @override
  Future<void> setFavourite(FavouriteModel favourite) {
    _service.
  }

  @override
  Future<void> deleteFavourite(FavouriteModel favourite) {
    // TODO: implement deleteFavourite
    throw UnimplementedError();
  }

  @override
  Stream<FavouriteModel> favouriteStream({String favouriteId}) {
    // TODO: implement favouriteStream
    throw UnimplementedError();
  }

  @override
  Stream<List<FavouriteModel>> favouritesStream() {
    // TODO: implement favouritesStream
    throw UnimplementedError();
  }
}