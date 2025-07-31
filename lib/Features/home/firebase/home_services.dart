import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Features/auth/models/user_model.dart';
import 'package:e_commerce/Features/home/models/category_model.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final String _categoriesCollection = 'categories';
  static final String _productsCollection = 'products';

  static Future<UserModel> getCurrentUserData() async {
    final userDoc = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (!userDoc.exists) {
      throw Exception('User not found');
    }

    return UserModel.fromFirestore(userDoc.data()!, userDoc.id);
  }

  static Stream<List<CategoryModel>> getCategories() {
    return _firestore
        .collection(_categoriesCollection)
        .where('isAvailable', isEqualTo: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CategoryModel.fromFirestore(doc.data(), doc.id))
              .toList(),
        );
  }

  static Stream<List<ProductModel>> getProductsByCategory({
    String? categoryId,
    String? orderBy,
    bool descending = false,
  }) {
    Query query = _firestore
        .collection(_productsCollection)
        .where('categoryId', isEqualTo: categoryId)
        .where('isAvailable', isEqualTo: true);

    // لو في ترتيب مضاف
    if (orderBy != null) {
      query = query.orderBy(orderBy, descending: descending);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => ProductModel.fromFirestore(
              doc.data() as Map<String, dynamic>,
              doc.id,
            ),
          )
          .toList();
    });
  }

  static Stream<List<ProductModel>> getAllProducts() {
    try {
      return _firestore
          .collection(_productsCollection)
          .where('isAvailable', isEqualTo: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return ProductModel.fromFirestore(doc.data(), doc.id);
            }).toList();
          });
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }
}
