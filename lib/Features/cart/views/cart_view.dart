import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Features/auth/widgets/button.dart';
import 'package:e_commerce/Features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/Features/cart/cubit/cart_state.dart';
import 'package:e_commerce/Features/cart/models/cart_model.dart';
import 'package:e_commerce/Features/cart/widgets/product_in_cart.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Cart', actions: []),
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
              Container(
                margin: const EdgeInsets.all(8),
                height: 150,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal'),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
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
                    CustomButton(name: 'Checkout', onPressed: () {}),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
