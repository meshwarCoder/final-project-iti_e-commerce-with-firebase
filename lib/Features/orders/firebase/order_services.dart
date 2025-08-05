import 'package:cloud_firestore/cloud_firestore.dart';

class OrderServices {
  static Future<void> clearOrders(String userId) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final ordersRef = firestore
          .collection('users')
          .doc(userId)
          .collection('orders');

      final snapshot = await ordersRef.get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to clear orders: $e');
    }
  }
}
