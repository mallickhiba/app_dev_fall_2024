import 'package:cloud_firestore/cloud_firestore.dart';

class JuiceService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchJuice() async {
    final querySnapshot = await _store.collection('juices').get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
