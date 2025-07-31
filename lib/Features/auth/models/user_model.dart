class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;
  final String password;
  final String gender;
  final bool isAdmin;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.gender,
    required this.isAdmin,
    this.createdAt,
  });

  // Factory constructor to create UserModel from Firestore data
  factory UserModel.fromFirestore(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      password: map['password'] ?? '',
      gender: map['gender'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      createdAt: map['createdAt']?.toDate(),
    );
  }

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'password': password,
      'gender': gender,
      'isAdmin': isAdmin,
      'createdAt': createdAt ?? DateTime.now(),
    };
  }
}
