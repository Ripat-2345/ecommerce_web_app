import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_icon_button_widget.dart';
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
        height: 310,
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
                    SizedBox(
                      width: 230,
                      child: Text(
                        "White Sweater Mandfffff fffffdf dfffffffffffffffffff",
                        style: TextStyle(
                          color: darkBlueColor,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rp.150.000",
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                CustomIconButtonWidget(
                  onTap: () {},
                  iconButton: Icons.add_shopping_cart_rounded,
                  iconSize: 20,
                  iconColor: Colors.black,
                  width: 45,
                  height: 45,
                  color: yellowColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
