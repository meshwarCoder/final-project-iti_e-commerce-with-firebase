class CartItemModel {
  final String productId;
  final String title;
  final String imageUrl;
  final num price;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromFirestore(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
