import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchTransactions() async {
    final querySnapshot = await _store.collection('transactions').get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  // Future<void> addTransaction(String name, String email) async {
  //   try {
  //     await _store.collection('transactions').add({
  //       'name': name,
  //       'email': email,
  //     });
  //     debugPrint('added');
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<void> deleteTransaction(String name, String email) async {
  //   try {
  //     final querySnapshot = await _store
  //         .collection('transactions')
  //         .where('name', isEqualTo: name)
  //         .where('email', isEqualTo: email)
  //         .get();
  //     for (var doc in querySnapshot.docs) {
  //       await _store.collection('transactions').doc(doc.id).delete();
  //     }
  //     debugPrint('deleted');
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
