import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomProductWidget extends StatelessWidget {
  const CustomProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed('product');
      },
      child: Container(
        width: 250,
        height: 300,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/images/product1.jpg"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sold: 100+",
                      style: TextStyle(
                        color: yellowColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "White Sweater Man",
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price:",
                      style: TextStyle(
                        color: yellowColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "Rp.150.000",
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                CustomFilledButtonWidget(
                  widthButton: 100,
                  heightButton: 35,
                  backgroundButton: yellowColor,
                  textButtonColor: darkBlueColor,
                  textButtonSize: 12,
                  textButtonFontWeight: FontWeight.w700,
                  title: "Buy Now",
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
