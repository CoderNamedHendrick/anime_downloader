import 'package:anime_downloader/services/firebase_model.dart';
import 'package:anime_downloader/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {
  Future<void> create();
  Future<void> addSaved(FavouriteModel favourite);
  Future<void> deleteSaved(FavouriteModel favourite);
  Stream<DocumentSnapshot> savedStream();
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid, required this.email});
  final String uid;
  final String email;
  final _service = FirestoreService.instance;

  @override
  Future<void> create() async {
    _service.create(uid: uid, email: email);
  }

  @override
  Future<void> addSaved(FavouriteModel favourite) async {
    try {
      await _service.addSaved(
        uid: uid,
        data: favourite.toMap(),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteSaved(FavouriteModel favourite) async {
    try {
      await _service.deleteSaved(
        uid: uid,
        data: favourite.toMap(),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Stream<DocumentSnapshot> savedStream() {
    return _service.savedStream(uid: uid);
  }
}
