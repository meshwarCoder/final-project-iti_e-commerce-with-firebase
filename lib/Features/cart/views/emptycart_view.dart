import 'package:flutter/material.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: const Center(
        child: Column(
          children: [
            Icon(Icons.shopping_cart, size: 100),
            Text('Your Cart is Empty'),
          ],
        ),
      ),
    );
  }
}
