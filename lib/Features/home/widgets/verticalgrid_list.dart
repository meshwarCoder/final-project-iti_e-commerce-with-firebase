import 'package:e_commerce/Features/home/cubit/home_cubit.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:e_commerce/Features/home/widgets/item_in%20vertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerticalGridList extends StatelessWidget {
  final List<ProductModel> products;
  const VerticalGridList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = context.read<HomeCubit>().products;
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.4,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ItemInVertical(
          product: products[index],
          // onTap: ()
        );
      },
    );
  }
}
