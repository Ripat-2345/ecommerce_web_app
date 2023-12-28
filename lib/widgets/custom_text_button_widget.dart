import 'package:flutter/material.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final double textSize;
  final FontWeight textWeight;
  final Color overlayColor;
  final VoidCallback onPressed;
  const CustomTextButtonWidget({
    super.key,
    required this.title,
    required this.textColor,
    required this.textSize,
    required this.textWeight,
    this.overlayColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
        ),
        overlayColor: MaterialStateProperty.all(overlayColor),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: textSize,
          fontWeight: textWeight,
        ),
      ),
    );
  }
}
