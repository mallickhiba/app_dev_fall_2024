import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Friends {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<void> addFriend(String name, String email) async {
    try {
      await _store.collection('friends').add({
        'name': name,
        'email': email,
      });
      debugPrint('added');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteFriend(String name, String email) async {
    try {
      final querySnapshot = await _store
          .collection('friends')
          .where('name', isEqualTo: name)
          .where('email', isEqualTo: email)
          .get();
      for (var doc in querySnapshot.docs) {
        await _store.collection('friends').doc(doc.id).delete();
      }
      debugPrint('deleted');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
