import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String title;
  const CustomTextFieldWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: blueColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: (screenWidth(context) >= laptopScreenSize) ? 50 : 40,
          width: (screenWidth(context) >= laptopScreenSize)
              ? 400
              : double.infinity,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: whiteColor,
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
