import 'package:flutter/material.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconButton;
  final double iconSize;
  final Color iconColor;
  final double width;
  final double height;
  final Color color;
  const CustomIconButtonWidget({
    super.key,
    required this.onTap,
    required this.iconButton,
    required this.iconSize,
    required this.iconColor,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Icon(
            iconButton,
            size: iconSize,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
