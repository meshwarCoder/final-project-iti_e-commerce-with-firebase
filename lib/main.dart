import 'package:e_commerce/Features/auth/views/login_view.dart';
import 'package:e_commerce/Features/auth/views/signup_view.dart';
import 'package:e_commerce/Features/home/home_view.dart';
import 'package:e_commerce/Features/splash/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseServices.initFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'SplashView',
      routes: {
        'SplashView': (context) => const SplashView(),
        'LoginView': (context) => LoginView(),
        'SignupView': (context) => const SignupView(),
        'HomeView': (context) => const HomeView(),
      },
    );
  }
}
