import 'package:flutter/material.dart';

void showSnackbar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white.withOpacity(0),
      content: Text(message),
    ),
  );
}
