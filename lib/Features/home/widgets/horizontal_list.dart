import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:e_commerce/Features/home/widgets/item_in_horzontal.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  final List<ProductModel> products;
  const HorizontalList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) =>
            ItemInHorizontal(product: products[index]),
      ),
    );
  }
}
