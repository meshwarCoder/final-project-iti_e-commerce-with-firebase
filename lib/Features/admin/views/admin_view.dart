import 'package:e_commerce/Features/admin/firebase/admin_services.dart';
import 'package:e_commerce/Features/admin/widgets/admin_search.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/Features/admin/widgets/categories_admintab.dart';
import 'package:e_commerce/Features/admin/widgets/productadmin_tab.dart';
import 'package:e_commerce/core/constant/colors.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: KColors.primaryColor,
              title: const Text('Admin', style: TextStyle(color: Colors.white)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    final tabIndex = DefaultTabController.of(context).index;

                    if (tabIndex == 0) {
                      final products =
                          await AdminServices.getAllProducts().first;
                      showSearch(
                        context: context,
                        delegate: AdminSearchDelegate(
                          items: products,
                          isProduct: true,
                        ),
                      );
                    } else {
                      final categories = await AdminServices.getCategories();
                      showSearch(
                        context: context,
                        delegate: AdminSearchDelegate(
                          items: categories,
                          isProduct: false,
                        ),
                      );
                    }
                  },
                ),
              ],
              bottom: const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: "Products"),
                  Tab(text: "Categories"),
                ],
              ),
            ),

            body: TabBarView(
              controller: tabController,
              children: [ProductsAdminTab(), CategoriesAdminTab()],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (tabController.index == 0) {
                  Navigator.pushNamed(context, 'AddEditProductView');
                } else {
                  Navigator.pushNamed(context, 'AddEditCategoryView');
                }
              },
              backgroundColor: KColors.primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
