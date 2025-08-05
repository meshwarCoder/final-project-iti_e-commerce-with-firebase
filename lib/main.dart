import 'package:e_commerce/Features/admin/views/addedit_categorey.dart';
import 'package:e_commerce/Features/admin/views/addedit_product_view.dart';
import 'package:e_commerce/Features/admin/views/admin_view.dart';
import 'package:e_commerce/Features/auth/views/login_view.dart';
import 'package:e_commerce/Features/auth/views/signup_view.dart';
import 'package:e_commerce/Features/cart/cubit/cart_cubit.dart';
import 'package:e_commerce/Features/cart/views/cart_view.dart';
import 'package:e_commerce/Features/helps&supports/helps_supports_view.dart';
import 'package:e_commerce/Features/home/cubit/home_cubit.dart';
import 'package:e_commerce/Features/home/views/home_view.dart';
import 'package:e_commerce/Features/orders/views/order_view.dart';
import 'package:e_commerce/Features/profile/views/profile_view.dart';
import 'package:e_commerce/Features/splash/views/splash_view.dart';
import 'package:e_commerce/Features/wishlist/views/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/Features/auth/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseServices.initFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => CartCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'SplashView',
        routes: {
          'SplashView': (context) => const SplashView(),
          'LoginView': (context) => LoginView(),
          'SignupView': (context) => const SignupView(),
          'HomeView': (context) => const HomeView(),
          'CartView': (context) => const CartView(),
          'OrderView': (context) => OrderView(),
          'ProfileView': (context) => ProfileView(),
          'WishlistView': (context) => WishlistView(),
          'AdminView': (context) => AdminView(),
          'AddEditCategoryView': (context) => AddEditCategoryView(),
          'AddEditProductView': (context) => AddEditProductView(),
          'HelpSupportView': (context) => HelpSupportView(),
        },
      ),
    );
  }
}
