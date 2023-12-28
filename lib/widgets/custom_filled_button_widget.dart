import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CustomFilledButtonWidget extends StatelessWidget {
  final String title;
  final double widthButton;
  final double heightButton;
  final Color backgroundButton;
  final Color textButtonColor;
  final double textButtonSize;
  final FontWeight textButtonFontWeight;
  final VoidCallback onPressed;
  const CustomFilledButtonWidget({
    super.key,
    required this.title,
    required this.widthButton,
    required this.heightButton,
    required this.backgroundButton,
    required this.textButtonColor,
    required this.textButtonSize,
    required this.textButtonFontWeight,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (screenWidth(context) >= laptopScreenSize)
          ? widthButton
          : double.infinity,
      height: heightButton,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundButton),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textButtonColor,
            fontSize: textButtonSize,
            fontWeight: textButtonFontWeight,
          ),
        ),
      ),
    );
  }
}
