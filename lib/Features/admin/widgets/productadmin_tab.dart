import 'package:e_commerce/Features/admin/widgets/admin_listtile.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:e_commerce/Features/admin/firebase/admin_services.dart';

class ProductsAdminTab extends StatelessWidget {
  const ProductsAdminTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: AdminServices.getAllProducts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!;
        if (products.isEmpty) {
          return const Center(child: Text('No products found'));
        }

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductListTile(product: product);
          },
        );
      },
    );
  }
}
