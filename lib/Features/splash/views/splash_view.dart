import 'package:e_commerce/Features/home/cubit/home_cubit.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (FirebaseServices.isLoggedIn()) {
        Navigator.pushReplacementNamed(context, 'HomeView');
        context.read<HomeCubit>().getHomeData();
      } else {
        Navigator.pushReplacementNamed(context, 'LoginView');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: 300,
                left: 40,
                child: SvgPicture.asset("assets/images/Light.svg"),
              ),
              Positioned(
                left: 66,
                bottom: 5,
                child: SvgPicture.asset("assets/images/Rope.svg"),
              ),
              Positioned(
                top: 270,
                left: 104,
                child: SvgPicture.asset("assets/images/Light.svg"),
              ),
              Positioned(
                left: 130,
                bottom: 40,
                child: SvgPicture.asset("assets/images/Rope.svg"),
              ),
              Align(
                heightFactor: 5,
                child: SvgPicture.asset("assets/images/LOGO.svg"),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(10, -10),
            child: SvgPicture.asset("assets/images/splash.svg", height: 400),
          ),
          const SizedBox(height: 30),
          Transform.translate(
            offset: Offset(0, -50),

            child: Text(
              "shopping with LOGO",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Transform.translate(
            offset: Offset(0, -50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LOGO makes shopping easy\n and fun!",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
