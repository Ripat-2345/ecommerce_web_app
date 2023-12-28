import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:flutter/material.dart';

class CustomProfileDisplayWidget extends StatelessWidget {
  const CustomProfileDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Howday, Mika chan",
              style: TextStyle(
                color: whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
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
            image: const DecorationImage(
              image: AssetImage("assets/images/user.png"),
            ),
          ),
        ),
      ],
    );
  }
}
