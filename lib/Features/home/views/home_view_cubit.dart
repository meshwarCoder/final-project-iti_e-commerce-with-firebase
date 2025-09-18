import 'package:e_commerce/Features/auth/views/login_view.dart';
import 'package:e_commerce/Features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/Features/home/firebase/home_services.dart';
import 'package:e_commerce/Features/home/models/category_model.dart';
import 'package:e_commerce/Features/home/views/categoryproduct_view.dart';
import 'package:e_commerce/Features/home/widgets/Product_search.dart';
import 'package:e_commerce/Features/home/widgets/categories_list.dart';
import 'package:e_commerce/Features/home/widgets/custom_listtile.dart';
import 'package:e_commerce/Features/home/widgets/horizontal_list.dart';
import 'package:e_commerce/Features/home/widgets/verticalgrid_list.dart';
import 'package:e_commerce/Features/profile/presentation/cubits/get%20profile%20data%20cubit/get_profile_data_cubit_cubit.dart';
import 'package:e_commerce/core/constant/colors.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final productsStream = HomeServices.getAllProducts();
              final products = await productsStream.first;
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(products),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              context.read<CartCubit>().getCartItems();
              Navigator.pushNamed(context, 'CartView');
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: KColors.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child:
                  BlocBuilder<
                    GetProfileDataCubitCubit,
                    GetProfileDataCubitState
                  >(
                    builder: (context, state) {
                      if (state is ProfileLoadedData) {
                        final user = state.user;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Text(
                                user.fullName.isNotEmpty
                                    ? user.fullName[0]
                                    : "?",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user.fullName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
            ),
            CustomListTile(
              title: 'Home',
              icon: Icons.home,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            CustomListTile(
              title: 'Cart',
              icon: Icons.shopping_cart_outlined,
              onTap: () {
                Navigator.pushNamed(context, 'CartView');
              },
            ),
            CustomListTile(
              title: 'Orders',
              icon: Icons.list_alt,
              onTap: () {
                Navigator.pushNamed(context, 'OrderView');
              },
            ),
            CustomListTile(
              title: 'Wishlist',
              icon: Icons.favorite,
              onTap: () {
                Navigator.pushNamed(context, 'WishlistView');
              },
            ),
            FutureBuilder<bool>(
              future: FirebaseServices.isCurrentUserAdmin(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return CustomListTile(
                    title: 'Admin Page',
                    icon: Icons.admin_panel_settings,
                    onTap: () {
                      Navigator.pushNamed(context, 'AdminView');
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            const Divider(color: Colors.white24),
            CustomListTile(
              title: 'Profile',
              icon: Icons.person,
              onTap: () {
                // Navigator.pushNamed(context, 'ProfileView').then((_) {
                //   setState(() {}); // بعد العودة من صفحة البروفايل
                // });
                Navigator.pushNamed(context, 'ProfileView');
              },
            ),
            CustomListTile(
              title: 'Helps & Support',
              icon: Icons.support_agent,
              onTap: () {
                Navigator.pushNamed(context, 'HelpSupportView');
              },
            ),
            const Spacer(),
            const Divider(color: Colors.white24),
            CustomListTile(
              title: 'Logout',
              icon: Icons.logout,
              color: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color(0xFF2B3840),
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to logout?',
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
                            FirebaseServices.signOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Shopping by Category',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            StreamBuilder<List<CategoryModel>>(
              stream: HomeServices.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error loading categories\n${snapshot.error}"),
                  );
                }
                final categories = snapshot.data ?? [];
                return Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: CategoryList(
                    categories: categories,
                    onCategorySelected: (category) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryProductsView(category: category),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Featured Products',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            StreamBuilder(
              stream: HomeServices.getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error loading products\n${snapshot.error}"),
                  );
                }
                final products = snapshot.data ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HorizontalList(products: products),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'New Arrivals',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    VerticalGridList(products: products),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
