import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:flutter/material.dart';

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            username.isNotEmpty
                ? Text(
                    "Howday, $username",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const SizedBox(),
            Row(
              children: [
                Icon(
                  Icons.wallet,
                  size: 24,
                  color: whiteColor,
                ),
                const SizedBox(width: 5),
                Text(
                  "Rp.45000",
                  style: TextStyle(
                    color: yellowColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 10),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: pictUrl.isEmpty
                  ? const AssetImage("assets/images/user.png") as ImageProvider
                  : NetworkImage('$baseUrl/$pictUrl'),
            ),
          ),
        ),
      ],
    );
  }
}
