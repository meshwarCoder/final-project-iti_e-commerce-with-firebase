class ProductModel {
  String id;
  final String title;
  final String description;
  final num price;
  final String imageUrl;
  final String categoryId;
  final bool isAvailable;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.isAvailable,
  });

  ProductModel.fromFirestore(Map<String, dynamic> json, String id)
    : id = json['id'],
      title = json['title'],
      description = json['description'],
      price = json['price'],
      imageUrl = json['imageUrl'],
      isAvailable = json['isAvailable'],
      categoryId = json['categoryId'];

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'categoryId': categoryId,
    };
  }
}
