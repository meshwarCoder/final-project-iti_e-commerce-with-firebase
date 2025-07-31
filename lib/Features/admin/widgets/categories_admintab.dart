import 'package:flutter/material.dart';
import 'package:e_commerce/Features/home/models/category_model.dart';
import 'package:e_commerce/Features/admin/firebase/admin_services.dart';
import 'package:e_commerce/Features/admin/widgets/category_listtile.dart';

class CategoriesAdminTab extends StatelessWidget {
  const CategoriesAdminTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryModel>>(
      stream: AdminServices.getAllCategories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final categories = snapshot.data!;
        if (categories.isEmpty) {
          return const Center(child: Text('No categories found'));
        }

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryListTile(category: category);
          },
        );
      },
    );
  }
}
