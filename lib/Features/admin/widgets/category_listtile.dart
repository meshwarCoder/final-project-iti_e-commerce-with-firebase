import 'package:e_commerce/Features/admin/views/addedit_categorey.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/Features/admin/firebase/admin_services.dart';
import 'package:e_commerce/Features/home/models/category_model.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(child: Text(category.name[0].toUpperCase())),
        title: Text(category.name),
        subtitle: Text(category.isAvailable ? 'Visible' : 'Hidden'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditCategoryView(category: category),
                ),
              );
            } else if (value == 'delete') {
              await AdminServices.deleteCategory(category.id);
            } else if (value == 'toggle') {
              await AdminServices.toggleCategoryVisibility(
                category.id,
                category.isAvailable,
              );
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'delete', child: Text('Delete')),
            PopupMenuItem(value: 'toggle', child: Text('Hide/Show')),
          ],
        ),
      ),
    );
  }
}
