import 'package:e_commerce/core/constant/colors.dart';
import 'package:flutter/material.dart';

void showSnackbar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(backgroundColor: KColors.primaryColor, content: Text(message)),
  );
}
