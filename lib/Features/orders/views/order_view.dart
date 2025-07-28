import 'package:e_commerce/Features/cart/widgets/product_in_cart.dart';
import 'package:e_commerce/Features/orders/models/order_model.dart';
import 'package:e_commerce/Features/orders/widgets/order_item.dart';
import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  final List<Order> orders = [
    Order(
      orderId: '1',
      totalPrice: 100.0,
      products: ['Product 1', 'Product 2'],
    ),
    Order(
      orderId: '2',
      totalPrice: 150.0,
      products: ['Product 3', 'Product 4'],
    ),
  ];

  OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Orders',
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
                        'Clear Orders',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to clear all orders?',
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
                          onPressed: () {},
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
                    Text('Clear Orders'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 180,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Expanded(
                  child: Column(
                    children: [
                      Spacer(),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: KColors.primaryColor,
                        size: 40,
                      ),
                      Spacer(),
                      Text(
                        '10',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: KColors.primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Orders',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: KColors.primaryColor,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                VerticalDivider(color: KColors.primaryColor),
                Expanded(
                  child: Column(
                    children: [
                      Spacer(),
                      Icon(
                        Icons.attach_money_outlined,
                        color: KColors.primaryColor,
                        size: 40,
                      ),
                      Spacer(),
                      Text(
                        '\$1000',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: KColors.primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: KColors.primaryColor,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: orders
                  .map(
                    (order) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OrderItem(order: order),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
