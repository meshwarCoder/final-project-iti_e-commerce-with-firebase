import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:e_commerce/Features/home/widgets/item_in%20vertical.dart';
import 'package:flutter/material.dart';

class ProductSearchDelegate extends SearchDelegate {
  final List<ProductModel> products;

  ProductSearchDelegate(this.products);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildGrid(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildGrid(suggestions);
  }

  Widget _buildGrid(List<ProductModel> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // نفس عدد الأعمدة ف الهوم
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.65, // اضبطه حسب تصميمك
      ),
      itemBuilder: (context, index) {
        return ItemInVertical(product: items[index]);
      },
    );
  }
}
