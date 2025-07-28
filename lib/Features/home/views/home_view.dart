import 'package:e_commerce/Features/auth/views/login_view.dart';
import 'package:e_commerce/Features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/Features/home/cubit/home_cubit.dart';
import 'package:e_commerce/Features/home/cubit/home_state.dart';
import 'package:e_commerce/Features/home/widgets/custom_listtile.dart';
import 'package:e_commerce/Features/home/widgets/horizontal_list.dart';
import 'package:e_commerce/Features/home/widgets/verticalgrid_list.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:e_commerce/core/widgets/Custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              context.read<CartCubit>().getCartItems();
              Navigator.pushNamed(context, 'CartView');
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF2B3840),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(radius: 30),
                  const SizedBox(height: 10),
                  Text(
                    'User Name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'dhuid@user.com',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
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
            const Divider(color: Colors.white24),

            CustomListTile(
              title: 'Profile',
              icon: Icons.person,
              onTap: () {
                Navigator.pushNamed(context, 'ProfileView');
              },
            ),
            CustomListTile(
              title: 'Helps & Support',
              icon: Icons.support_agent,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Spacer(),
            Divider(color: Colors.white24),
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
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
            SizedBox(height: 10),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeSuccessState) {
              return Column(
                children: [
                  HorizontalList(products: state.products),
                  SizedBox(height: 15),
                  VerticalGridList(
                    products: context.read<HomeCubit>().products,
                  ),
                ],
              );
            } else if (state is HomeErrorState) {
              return Center(child: Text(state.toString()));
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
