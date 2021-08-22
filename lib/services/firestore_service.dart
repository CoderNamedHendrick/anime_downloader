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

  Future<void> addSaved({
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

  Future<void> deleteSaved({
    @required String uid,
    @required Map<String, dynamic> data,
  }) async {
    final reference = _firestore.collection('users').doc('$uid');
    await reference.update({
      'saved': FieldValue.arrayRemove([data])
    });
  }

  Stream<DocumentSnapshot> savedStream<T>({
    @required String uid,
  }) {
    final reference = _firestore.collection('users').doc('$uid');
    final snapshots = reference.snapshots();
    return snapshots;
  }
}
