import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseEditProfileServices {
  static Future<void> updateUserData({
    required String fullName,
    required String phoneNumber,
    required String address,
    required String password,
  }) async {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    await userRef.update({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'password': password,
    });
  }

  static Stream<UserModel> getCurrentUserStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((doc) => UserModel.fromFirestore(doc.data()!, doc.id));
  }
}
