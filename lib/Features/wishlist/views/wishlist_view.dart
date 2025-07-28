import 'package:e_commerce/Features/home/widgets/verticalgrid_list.dart';
import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:flutter/material.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Wishlist',
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
                        'Clear Wishlist',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to clear all wishlist?',
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
              if (value == 1) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xFF2B3840),
                      title: const Text(
                        'Add Wishlist To Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to add all wishlist to cart?',
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
                            'Add',
                            style: TextStyle(color: Colors.green),
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
                    Text('Clear Wishlist'),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: const [
                    Icon(
                      Icons.card_travel_outlined,
                      color: KColors.primaryColor,
                    ),
                    Text('Add All To Cart'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],

                borderRadius: BorderRadius.circular(12),
                // color: Colors.grey[300],
              ),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.favorite, color: KColors.primaryColor, size: 25),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2 items in your wishlist',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: KColors.primaryColor,
                          ),
                        ),
                        Text(
                          'Add items to your wishlist and they will appear here',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 11,
                            color: KColors.primaryColor.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KColors.primaryColor,
                    ),
                    child: Text(
                      'Add to cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              // child: VerticalGridList(p),
            ),
          ],
        ),
      ),
    );
  }
}
