import 'package:e_commerce/Features/cart/models/cart_model.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:flutter/material.dart';

class ItemInVertical extends StatefulWidget {
  final ProductModel product;

  const ItemInVertical({super.key, required this.product});

  @override
  State<ItemInVertical> createState() => _ItemInVerticalState();
}

class _ItemInVerticalState extends State<ItemInVertical> {
  bool isWishlisted = false;
  bool isCarted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                        widget.product.imageUrl,
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
                          widget.product.title,
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
                          widget.product.description,
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
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                radius: 20,
                child: Center(
                  child: IconButton(
                    icon: Icon(
                      isWishlisted ? Icons.favorite : Icons.favorite_border,
                      color: isWishlisted ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isWishlisted = !isWishlisted;
                      });
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  isCarted ? Icons.check : Icons.add_shopping_cart,
                  color: isCarted ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  if (!isCarted) {
                    FirebaseServices.addToCart(
                      userId: FirebaseServices.getCurrentUser()!.uid,
                      item: CartItemModel(
                        productId: widget.product.id.toString(),
                        title: widget.product.title,
                        imageUrl: widget.product.imageUrl,
                        price: widget.product.price,
                        quantity: 1,
                      ),
                    );
                  }
                  setState(() {
                    isCarted = !isCarted;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
