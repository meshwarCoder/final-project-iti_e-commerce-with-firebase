import 'package:e_commerce/Features/cart/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final num totalPrice;
  final DateTime createdAt;
  final List<CartItemModel> orderItems;

  OrderModel({
    required this.id,
    required this.totalPrice,
    required this.createdAt,
    required this.orderItems,
  });

  factory OrderModel.fromFirestore(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      totalPrice: json['totalPrice'] ?? 0,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      orderItems:
          (json['orderItems'] as List<dynamic>?)
              ?.map(
                (item) =>
                    CartItemModel.fromFirestore(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,

      'totalPrice': totalPrice,
      'createdAt': Timestamp.fromDate(createdAt),
      'orderItems': orderItems.map((e) => e.toFirestore()).toList(),
    };
  }
}
