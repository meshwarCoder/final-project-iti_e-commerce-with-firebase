import 'package:e_commerce/Features/admin/widgets/admin_listtile.dart';
import 'package:e_commerce/Features/admin/widgets/category_listtile.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:e_commerce/Features/home/models/category_model.dart';

class AdminSearchDelegate<T> extends SearchDelegate<T?> {
  final List<dynamic> items; // ممكن تبقى Products أو Categories
  final bool isProduct;

  AdminSearchDelegate({required this.items, this.isProduct = true});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
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
    final results = items.where((item) {
      final name = isProduct
          ? (item as ProductModel).title
          : (item as CategoryModel).name;
      return name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return isProduct
            ? ProductListTile(product: item)
            : CategoryListTile(category: item);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
