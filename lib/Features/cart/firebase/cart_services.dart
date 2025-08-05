import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce/Features/cart/models/cart_model.dart';

class CartServices {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> clearCart(String userId) async {
    try {
      final cartRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('cart');

      final snapshot = await cartRef.get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }

  // إضافة المنتج للكارت أو تحديثه
  static Future<void> addOrRemoveFromCart(CartItemModel item) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final cartRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(item.productId);

    final doc = await cartRef.get();

    if (doc.exists) {
      // لو المنتج موجود → احذفه من الكارت
      await cartRef.delete();
    } else {
      // لو المنتج مش موجود → أضفه
      await cartRef.set(item.toFirestore());
    }
  }

  // التحقق إذا المنتج موجود في الكارت
  static Stream<bool> isInCart(String productId) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final doc = _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .snapshots();

    return doc.map((doc) => doc.exists);
  }
}
