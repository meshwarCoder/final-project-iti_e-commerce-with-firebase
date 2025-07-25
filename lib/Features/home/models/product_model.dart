class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isAvailable;
  final bool isFavorite;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.isAvailable,
    required this.isFavorite,
  });

  ProductModel.fromFirestore(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      description = json['description'],
      price = json['price'],
      imageUrl = json['imageUrl'],
      isAvailable = json['isAvailable'],
      isFavorite = json['isFavorite'],
      category = json['category'];

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'isFavorite': isFavorite,
      'category': category,
    };
  }
}
