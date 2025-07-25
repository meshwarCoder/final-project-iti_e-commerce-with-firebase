import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.validation,
    required this.hintText,
    this.iconPath,
    this.iconData,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String? Function(String?)? validation;
  final String hintText;
  final String? iconPath;
  final IconData? iconData;
  final bool obscureText;
  final TextEditingController controller;
  final IconButton? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validation,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 30, right: 20),
            child: iconPath != null
                ? SvgPicture.asset(iconPath!, width: 20, height: 20)
                : Icon(iconData),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.roboto(
            color: Color.fromRGBO(81, 81, 81, 1),
            fontSize: 14,
          ),
          filled: true,
          fillColor: Color.fromRGBO(242, 242, 242, 1),
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
      ),
    );
  }
}
