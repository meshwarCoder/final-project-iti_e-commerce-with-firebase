import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:e_commerce/Features/home/models/category_model.dart';

class AdminServices {
  static final _firestore = FirebaseFirestore.instance;
  static final String _categoriesCollection = 'categories';
  static final String _productsCollection = 'products';

  /// ==================== المنتجات ====================

  // جلب كل المنتجات
  static Stream<List<ProductModel>> getAllProducts() {
    return _firestore
        .collection(_productsCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ProductModel.fromFirestore(doc.data(), doc.id))
              .toList(),
        );
  }

  // حذف منتج
  static Future<void> deleteProduct(String productId) async {
    await _firestore.collection(_productsCollection).doc(productId).delete();
  }

  // تعديل منتج
  static Future<void> updateProduct(
    String productId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection(_productsCollection)
        .doc(productId)
        .update(data);
  }

  // إخفاء/إظهار منتج
  static Future<void> toggleProductVisibility(
    String productId,
    bool isAvailable,
  ) async {
    await _firestore.collection(_productsCollection).doc(productId).update({
      'isAvailable': !isAvailable,
    });
  }

  /// ==================== الفئات ====================

  // جلب كل الفئات
  static Stream<List<CategoryModel>> getAllCategories() {
    return _firestore
        .collection(_categoriesCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CategoryModel.fromFirestore(doc.data(), doc.id))
              .toList(),
        );
  }

  // حذف فئة
  static Future<void> deleteCategory(String categoryId) async {
    await _firestore.collection(_categoriesCollection).doc(categoryId).delete();
  }

  // تعديل فئة
  static Future<void> updateCategory(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection(_categoriesCollection)
        .doc(categoryId)
        .update(data);
  }

  // إخفاء/إظهار فئة
  static Future<void> toggleCategoryVisibility(
    String categoryId,
    bool isAvailable,
  ) async {
    await _firestore.collection(_categoriesCollection).doc(categoryId).update({
      'isAvailable': !isAvailable,
    });
  }

  static Future<void> addProduct(ProductModel product) async {
    final docRef = _firestore.collection(_productsCollection).doc();
    product.id = docRef.id;
    await docRef.set(product.toFirestore());
  }

  static Future<List<CategoryModel>> getCategories() async {
    final snapshot = await _firestore.collection(_categoriesCollection).get();
    return snapshot.docs
        .map((doc) => CategoryModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  // إضافة كاتجوري جديدة
  static Future<void> addCategory(CategoryModel category) async {
    final docRef = _firestore.collection(_categoriesCollection).doc();
    category.id = docRef.id;
    await docRef.set(category.toFirestore());
  }
}
