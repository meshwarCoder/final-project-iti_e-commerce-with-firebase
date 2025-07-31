import 'package:e_commerce/Features/cart/models/cart_model.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductInCart extends StatelessWidget {
  final CartItemModel cartItem;
  const ProductInCart({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        margin: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
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
            ),
            SizedBox(width: 10),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      cartItem.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    children: [
                      Text(
                        '\$${cartItem.price}',
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(width: 40),
                      ProductCounter(cartItem: cartItem),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    await FirebaseServices.removeCartItem(
                      FirebaseAuth.instance.currentUser!.uid,
                      cartItem.productId,
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
                SizedBox(height: 10),
                Text(
                  ('\$${cartItem.price * cartItem.quantity}'),
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class ProductCounter extends StatelessWidget {
  final CartItemModel cartItem;
  const ProductCounter({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 90,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
              await FirebaseServices.decrementCartItemQuantity(
                FirebaseAuth.instance.currentUser!.uid,
                cartItem.productId,
              );
            },
            child: const Icon(Icons.remove, size: 16),
          ),
          Text(cartItem.quantity.toString(), style: TextStyle(fontSize: 14)),
          InkWell(
            onTap: () async {
              await FirebaseServices.incrementCartItemQuantity(
                FirebaseAuth.instance.currentUser!.uid,
                cartItem.productId,
              );
            },
            child: const Icon(Icons.add, size: 16),
          ),
        ],
      ),
    );
  }
}
