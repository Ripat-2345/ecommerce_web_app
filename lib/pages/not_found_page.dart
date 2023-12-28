import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: "Page Not Found",
      color: whiteColor,
      child: Scaffold(
        backgroundColor: lightYellowColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/404.png",
                  width: 600,
                ),
                const SizedBox(height: 50),
                Text(
                  "Page not found",
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
