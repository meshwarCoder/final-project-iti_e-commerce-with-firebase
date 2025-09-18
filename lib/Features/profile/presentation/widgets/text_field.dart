import 'package:e_commerce/core/constant/colors.dart';
import 'package:flutter/material.dart';

Widget showDataInTextField({
  required String label,
  required TextEditingController controller,
  required IconData icon,
  required bool readOnly,
  required String? Function(String?) validator,
  bool obscure = false,
  Widget? suffix,
}) {
  return TextFormField(
    controller: controller,
    readOnly: readOnly,
    obscureText: obscure,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: KColors.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
