import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_appbar_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';

class MarketPlacePage extends StatelessWidget {
  const MarketPlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            right: 20,
          ),
          children: [
            const CustomAppbarWidget(),
            const SizedBox(height: 60),
            Text(
              "Trend Product Now!",
              style: TextStyle(
                color: whiteColor,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 20),
            const Wrap(
              runSpacing: 20,
              alignment: WrapAlignment.spaceBetween,
              children: [
                // CustomProductWidget(),
                // CustomProductWidget(),
                // CustomProductWidget(),
                // CustomProductWidget(),
                // CustomProductWidget(),
                // CustomProductWidget(),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              "All Products To You",
              style: TextStyle(
                color: whiteColor,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 20),
            const Wrap(
              runSpacing: 30,
              alignment: WrapAlignment.spaceBetween,
              children: [
                // CustomProductWidget(),
                // CustomProductWidget(),
                // CustomProductWidget(),
                // CustomProductWidget(),
                // CustomProductWidget(),
                // CustomProductWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
