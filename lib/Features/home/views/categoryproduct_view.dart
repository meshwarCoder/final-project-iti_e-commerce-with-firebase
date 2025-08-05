import 'package:e_commerce/Features/home/firebase/home_services.dart';
import 'package:e_commerce/Features/home/views/emptycategory_view.dart';
import 'package:e_commerce/Features/home/widgets/item_in%20vertical.dart';
import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/Features/home/models/category_model.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';

class CategoryProductsView extends StatefulWidget {
  final CategoryModel category;

  const CategoryProductsView({super.key, required this.category});

  @override
  State<CategoryProductsView> createState() => _CategoryProductsViewState();
}

class _CategoryProductsViewState extends State<CategoryProductsView> {
  String selectedSort = 'Alphabetical';

  Stream<List<ProductModel>> _getSortedProducts() {
    switch (selectedSort) {
      case 'Alphabetical':
        return HomeServices.getProductsByCategory(
          categoryId: widget.category.id,
          orderBy: 'title',
          descending: false,
        );
      case 'AlphabeticalDesc':
        return HomeServices.getProductsByCategory(
          categoryId: widget.category.id,
          orderBy: 'title',
          descending: true,
        );
      case 'PriceLowHigh':
        return HomeServices.getProductsByCategory(
          categoryId: widget.category.id,
          orderBy: 'price',
          descending: false,
        );
      case 'PriceHighLow':
        return HomeServices.getProductsByCategory(
          categoryId: widget.category.id,
          orderBy: 'price',
          descending: true,
        );
      default:
        return HomeServices.getProductsByCategory(
          categoryId: widget.category.id,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.category.name,
        actions: [
          DropdownButton<String>(
            value: selectedSort,
            dropdownColor: KColors.primaryColor,

            underline: SizedBox(),
            icon: Icon(Icons.sort, color: Colors.white),
            items: const [
              DropdownMenuItem(
                value: 'Alphabetical',
                child: Text('A-Z', style: TextStyle(color: Colors.white)),
              ),
              DropdownMenuItem(
                value: 'AlphabeticalDesc',
                child: Text('Z-A', style: TextStyle(color: Colors.white)),
              ),
              DropdownMenuItem(
                value: 'PriceLowHigh',
                child: Text(
                  'Price: Low → High   ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DropdownMenuItem(
                value: 'PriceHighLow',
                child: Text(
                  'Price: High → Low   ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedSort = value!;
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _getSortedProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            throw Exception("Error loading products\n${snapshot.error}");
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: EmptyCategoryScreen());
          }

          final products = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ItemInVertical(product: products[index]);
            },
          );
        },
      ),
    );
  }
}
