import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
          right: 20,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/user.png",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Karina Anak Sapa",
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        CustomFilledButtonWidget(
                          title: "Edit Profile",
                          widthButton: 120,
                          heightButton: 35,
                          backgroundButton: blueColor,
                          textButtonColor: whiteColor,
                          textButtonSize: 14,
                          textButtonFontWeight: FontWeight.w500,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomFilledButtonWidget(
                      title: "Add Product",
                      widthButton: 150,
                      heightButton: 50,
                      backgroundButton: yellowColor,
                      textButtonColor: darkBlueColor,
                      textButtonSize: 18,
                      textButtonFontWeight: FontWeight.w800,
                      onPressed: () {},
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Text(
                  'My Products',
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
