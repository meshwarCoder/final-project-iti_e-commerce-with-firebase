import 'package:e_commerce/Features/cart/firebase/cart_services.dart';
import 'package:e_commerce/Features/cart/models/cart_model.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:e_commerce/Features/home/views/product_details.dart';
import 'package:e_commerce/Features/wishlist/firebase/wishlist_services.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:flutter/material.dart';

class ItemInVertical extends StatelessWidget {
  final ProductModel product;

  const ItemInVertical({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsView(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // زر الـ Wishlist
            Positioned(
              top: 5,
              right: 5,
              child: StreamBuilder<bool>(
                stream: WishlistServices.isInWishlistStream(product.id),
                builder: (context, snapshot) {
                  final isWishlisted = snapshot.data ?? false;
                  return CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    radius: 20,
                    child: IconButton(
                      icon: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: isWishlisted ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        if (isWishlisted) {
                          WishlistServices.removeFromWishlist(product.id);
                        } else {
                          WishlistServices.addToWishlist(product);
                        }
                      },
                    ),
                  );
                },
              ),
            ),

            // زر الكارت
            Positioned(
              bottom: 0,
              right: 5,
              child: StreamBuilder(
                stream: CartServices.isInCart(product.id),
                builder: (context, snapshot) {
                  final isInCart = snapshot.data ?? false;
                  return IconButton(
                    icon: Icon(
                      isInCart ? Icons.check : Icons.add_shopping_cart,
                      color: isInCart ? Colors.green : Colors.grey,
                    ),
                    onPressed: () {
                      if (isInCart) {
                        CartServices.addOrRemoveFromCart(
                          CartItemModel(
                            productId: product.id.toString(),
                            title: product.title,
                            imageUrl: product.imageUrl,
                            price: product.price,
                            quantity: 1,
                          ),
                        );
                      } else {
                        FirebaseServices.addToCart(
                          userId: FirebaseServices.getCurrentUser()!.uid,
                          item: CartItemModel(
                            productId: product.id.toString(),
                            title: product.title,
                            imageUrl: product.imageUrl,
                            price: product.price,
                            quantity: 1,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
