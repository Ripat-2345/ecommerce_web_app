import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: "Product",
      color: whiteColor,
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: Flex(
          direction: (screenWidth(context) >= laptopScreenSize)
              ? Axis.horizontal
              : Axis.vertical,
          crossAxisAlignment: (screenWidth(context) >= laptopScreenSize)
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 100,
              height: 100,
              color: whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
