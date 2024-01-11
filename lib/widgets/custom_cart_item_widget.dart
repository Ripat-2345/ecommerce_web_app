import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_icon_button_widget.dart';
import 'package:flutter/material.dart';

class CustomCartItemWidget extends StatelessWidget {
  final String name;
  final String description;
  final String qty;
  final String price;
  final String imgUrl;
  final VoidCallback removeQty;
  final VoidCallback addQty;
  const CustomCartItemWidget({
    super.key,
    required this.name,
    required this.description,
    required this.qty,
    required this.price,
    required this.imgUrl,
    required this.removeQty,
    required this.addQty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 520,
      height: 250,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: blueWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "$baseUrl/images/${imgUrl.split('\\')[1]}",
              width: 200,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 30),
                Text(
                  "Rp.${(int.parse(qty) * int.parse(price)).toString()}",
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CustomIconButtonWidget(
                      onTap: removeQty,
                      iconButton: Icons.remove_rounded,
                      iconSize: 24,
                      iconColor: darkBlueColor,
                      width: 40,
                      height: 40,
                      color: yellowColor,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      qty,
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 20),
                    CustomIconButtonWidget(
                      onTap: addQty,
                      iconButton: Icons.add_rounded,
                      iconSize: 24,
                      iconColor: yellowColor,
                      width: 40,
                      height: 40,
                      color: darkBlueColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
