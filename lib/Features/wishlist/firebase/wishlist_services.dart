import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WishlistServices {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> addToWishlist(ProductModel item) async {
    final docRef = _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishlist')
        .doc(item.id);

    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set(item.toFirestore());
    }
  }

  static Future<void> removeFromWishlist(String productId) async {
    await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishlist')
        .doc(productId)
        .delete();
  }

  static Stream<List<ProductModel>> getWishlist() {
    return _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishlist')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            return ProductModel(
              id: doc.id, // بنستخدم doc.id كـ id المنتج
              title: data['title'],
              price: (data['price'] as num),
              imageUrl: data['imageUrl'],
              description: data['description'],
              categoryId: data['categoryId'],
              isAvailable: data['isAvailable'],
            );
          }).toList(),
        );
  }

  static Stream<bool> isInWishlistStream(String productId) {
    return _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishlist')
        .doc(productId)
        .snapshots()
        .map((doc) => doc.exists);
  }

  static Future<bool> isInWishlist(String productId) async {
    final doc = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishlist')
        .doc(productId)
        .get();
    return doc.exists;
  }
}
