import 'package:e_commerce/Features/orders/firebase/order_services.dart';
import 'package:e_commerce/Features/orders/models/order_model.dart';
import 'package:e_commerce/Features/orders/views/emptyorder_view.dart';
import 'package:e_commerce/Features/orders/widgets/order_item.dart';
import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

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
                          onPressed: () {
                            OrderServices.clearOrders(
                              FirebaseAuth.instance.currentUser!.uid,
                            );
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
          Expanded(
            child: StreamBuilder<List<OrderModel>>(
              stream: FirebaseServices.getUserOrders(
                FirebaseAuth.instance.currentUser!.uid,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: EmptyOrdersScreen());
                }

                final ordersList = snapshot.data!;

                final totalAmount = ordersList.fold<num>(
                  0,
                  (sum, order) => sum + order.totalPrice,
                );

                return Column(
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
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Spacer(),
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: KColors.primaryColor,
                                  size: 40,
                                ),
                                const Spacer(),
                                Text(
                                  ordersList.length.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: KColors.primaryColor,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'Orders',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: KColors.primaryColor,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          const VerticalDivider(color: KColors.primaryColor),
                          Expanded(
                            child: Column(
                              children: [
                                const Spacer(),
                                const Icon(
                                  Icons.attach_money_outlined,
                                  color: KColors.primaryColor,
                                  size: 40,
                                ),
                                const Spacer(),
                                Text(
                                  '\$${totalAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: KColors.primaryColor,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: KColors.primaryColor,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ✅ بقية الليست
                    Expanded(
                      child: ListView.builder(
                        itemCount: ordersList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OrderItem(order: ordersList[index]),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
