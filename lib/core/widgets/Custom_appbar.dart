import 'package:e_commerce/core/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const CustomAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: KColors.primaryColor,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.white),
      actions: [...actions!],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
