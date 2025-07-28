import 'package:flutter/material.dart';

class ProductInOrder extends StatelessWidget {
  const ProductInOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Product Name'),
      subtitle: Text('Number of Products: 2'),
      trailing: Text('\$1000', style: TextStyle(color: Colors.green)),

      leading: Image.network(
        'src',
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
    );
    ;
  }
}
