import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void create({
    @required String uid,
    @required String email,
  }) async {
    try {
      await _firestore.collection('users').doc('$uid').set(
        {
          'email': '$email',
          'id': '$uid',
          'playlist': [],
          'saved': [],
        },
        SetOptions(
          mergeFields: [
            'id',
            'email',
          ],
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> addFavourite({
    @required String uid,
    @required Map<String, dynamic> data,
  }) async {
    try {
      final reference = _firestore.collection('users').doc('$uid');
      await reference.update({
        'saved': FieldValue.arrayUnion([data])
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFavourite({
    @required String uid,
    @required Map<String, dynamic> data,
  }) async {
    final reference = _firestore.collection('users').doc('$uid');
    await reference.update({
      'saved': FieldValue.arrayRemove([data])
    });
  }

  Stream<List<T>> favoriteStream<T>({
    @required String uid,
    @required T builder(Map<String, dynamic> data),
  }) {
    final reference = _firestore.collection('users').doc('$uid');
    final snapshots = reference.snapshots();
    print(snapshots.toList());
    // return snapshots.map((snapshot) {
    //   final result = snapshot['saved'].map((snap) => builder(snap)).toList();
    //   return result;
    // });
  }
}
