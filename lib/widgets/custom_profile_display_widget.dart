// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomProfileDisplayWidget extends StatelessWidget {
  final String username;
  final String pictUrl;
  const CustomProfileDisplayWidget({
    super.key,
    required this.username,
    required this.pictUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        username.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Howday, $username",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomFilledButtonWidget(
                    title: "Logout",
                    widthButton: 60,
                    heightButton: 30,
                    backgroundButton: Colors.red,
                    textButtonColor: whiteColor,
                    textButtonSize: 14,
                    textButtonFontWeight: FontWeight.w500,
                    onPressed: () async {
                      await removeFromStorage('authData');
                      context.goNamed('home');
                    },
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(width: 10),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: pictUrl.isEmpty
                  ? const AssetImage("assets/images/user.png") as ImageProvider
                  : NetworkImage("$baseUrl/images/${pictUrl.split('\\')[1]}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
