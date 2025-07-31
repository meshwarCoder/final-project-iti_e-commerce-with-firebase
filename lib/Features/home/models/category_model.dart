class CategoryModel {
  String id;
  final String name;
  final bool isAvailable;

  CategoryModel({
    required this.id,
    required this.name,
    this.isAvailable = true,
  });

  factory CategoryModel.fromFirestore(Map<String, dynamic> data, String id) {
    return CategoryModel(
      id: id,
      name: data['name'],
      isAvailable: data['isAvailable'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'name': name, 'id': id, 'isAvailable': isAvailable};
  }
}
