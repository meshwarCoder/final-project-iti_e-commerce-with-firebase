import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Features/auth/widgets/button.dart';
import 'package:e_commerce/Features/cart/models/cart_model.dart';
import 'package:e_commerce/Features/cart/widgets/product_in_cart.dart';
import 'package:e_commerce/Features/orders/models/order_model.dart';
import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:e_commerce/core/utils/snackbar.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cart',
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xFF2B3840),
                      title: const Text(
                        'Clear Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to clear all cart items?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // FirebaseServices.clearCart(
                            //   FirebaseAuth.instance.currentUser!.uid,
                            // );
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: const [
                    Icon(Icons.delete, color: KColors.primaryColor),
                    Text('Clear Cart'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<CartItemModel>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
            .snapshots()
            .map(
              (snapshot) => snapshot.docs
                  .map((doc) => CartItemModel.fromFirestore(doc.data()))
                  .toList(),
            ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }

          final cartItems = snapshot.data!;
          final total = cartItems.fold<double>(
            0,
            (sum, item) => sum + item.price * item.quantity,
          );

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return ProductInCart(cartItem: cartItems[index]);
                  },
                ),
              ),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal item'),
                          Text(
                            '${cartItems.fold(0, (previousValue, element) => previousValue + element.quantity)} items',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Amount'),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      Spacer(),
                      CustomButton(
                        name: 'Checkout',
                        onPressed: () async {
                          await FirebaseServices.addOrder(
                            OrderModel(
                              id: '',
                              orderItems: cartItems,
                              totalPrice: total,
                              createdAt: DateTime.now(),
                            ),
                          );
                          showSnackbar(
                            context: context,
                            message: 'Order Added Successfully',
                          );
                        },
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
