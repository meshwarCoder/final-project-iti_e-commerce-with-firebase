import 'package:e_commerce/Features/admin/firebase/admin_services.dart';
import 'package:e_commerce/Features/admin/views/addedit_product_view.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
                size: 50,
              ),
            );
          },
        ),
        title: Text(product.title),
        subtitle: Text(product.isAvailable ? 'Available' : 'Hidden'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditProductView(product: product),
                ),
              );
            } else if (value == 'delete') {
              await AdminServices.deleteProduct(product.id);
            } else if (value == 'toggle') {
              await AdminServices.toggleProductVisibility(
                product.id,
                product.isAvailable,
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
