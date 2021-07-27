import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({
    @required String path,
    @required String email,
    @required String uid,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(
      {
        'email': email,
        'id': uid,
        'saved': [],
        'playlist': [],
      },
      SetOptions(
        merge: true,
        mergeFields: ['saved'],
      ),
    );
  }

  Future<void> addFavourite({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.update({
      'saved': FieldValue.arrayUnion([data])
    });
  }

  Future<void> deleteFavourite(
      {@required String path, @required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.update({
      'saved': FieldValue.arrayRemove([data])
    });
  }

  Stream<List<T>> favouriteStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data),
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    print(snapshots);
    return snapshots.map((snapshot) {
      final result = snapshot['saved'].map((snap) => builder(snap)).toList();
      return result;
    });
  }
}
