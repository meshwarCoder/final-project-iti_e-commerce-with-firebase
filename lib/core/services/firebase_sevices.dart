import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Features/auth/models/user_model.dart';
import 'package:e_commerce/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  //init firebase
  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        throw ('Invalid email format.');
      } else if (e.code == 'user-disabled') {
        throw ('This account has been disabled.');
      } else if (e.code == 'invalid-credential') {
        throw ('Invalid email or password.');
      } else {
        throw ('Login failed: ${e.message}');
      }
    } catch (e) {
      rethrow;
    }
  }

  //verification
  static Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  static Future<bool> isEmailVerified() async {
    if (_auth.currentUser != null) {
      await _auth.currentUser!.reload();
      return _auth.currentUser!.emailVerified;
    }

    return false;
  }

  static Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If the user cancels the sign-in process
      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return userCredential.user;
    } catch (e) {
      throw ('Google Sign-In failed: ${e.toString()}');
    }
  }

  // عشان لما تخش تسجل بجوجل يعرض لك الحسابات مش يخش بالجساب ال سجلت بيه قبل كدا
  static Future<void> disconnectWithGoogle() async {
    try {
      await _googleSignIn.disconnect();
    } catch (e) {
      throw ('Google Sign-Out failed: ${e.toString()}');
    }
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> signOut() async {
    await disconnectWithGoogle();
    await _auth.signOut();
  }

  static bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  //firestore services
  static Future<void> createUserInFirestore(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  static Future<bool> checkUserExists(String email) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
