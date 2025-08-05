import 'package:flutter/material.dart';
import 'package:e_commerce/Features/cart/models/cart_model.dart';

class ProductInOrder extends StatelessWidget {
  final CartItemModel cartItem;
  const ProductInOrder({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartItem.title),
      subtitle: Text('Number of Products: ${cartItem.quantity}'),
      trailing: Text(
        '\$${cartItem.price}',
        style: TextStyle(color: Colors.green),
      ),

      leading: Image.network(
        cartItem.imageUrl,
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
  }
}
