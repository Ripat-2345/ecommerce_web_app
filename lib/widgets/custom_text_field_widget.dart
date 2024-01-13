import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String title;
  final bool obscureText;
  final TextEditingController? controller;
  final double width;
  const CustomTextFieldWidget({
    super.key,
    required this.title,
    this.obscureText = false,
    this.controller,
    this.width = 400,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: blueColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: (screenWidth(context) >= laptopScreenSize) ? 50 : 40,
          width: (screenWidth(context) >= laptopScreenSize)
              ? width
              : double.infinity,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              filled: true,
              fillColor: whiteColor,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: blueColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: darkBlueColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
