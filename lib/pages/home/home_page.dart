// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_product_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final List? dataProducts;
  const HomePage({
    super.key,
    this.dataProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        const SizedBox(height: 50),
        // todo: carousel section
        adsCarouselSlider(),
        const SizedBox(height: 100),
        // todo: brand section
        dummyBrands(),
        const SizedBox(height: 100),
        // todo: about us
        aboutUsSection(context),
        const SizedBox(height: 100),
        // todo: special offer
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Our Products!",
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 50),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: dataProducts == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Row(
                        children: dataProducts!.map((data) {
                          return Container(
                            margin: const EdgeInsets.only(
                              right: 40,
                            ),
                            child: CustomProductWidget(
                              idProduct: data['id'].toString(),
                              productName: data['name'],
                              price: data['price'].toString(),
                              description: data['description'],
                              productImageUrl: data['picture'],
                              textColor: darkBlueColor,
                            ),
                          );
                        }).toList(),
                        // SizedBox(width: 50),
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 100),
        // todo: footer
        homeFooter(context),
      ],
    );
  }

// todo: carousel ads
  CarouselSlider adsCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 600.0,
        autoPlay: true,
      ),
      items: [
        "assets/images/ads1.jpg",
        "assets/images/ads2.jpg",
        "assets/images/ads3.jpg",
        "assets/images/ads4.jpg",
      ].map((pict) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image:
                    DecorationImage(image: AssetImage(pict), fit: BoxFit.cover),
              ),
            );
          },
        );
      }).toList(),
    );
  }

// todo: dummy brand
  Container dummyBrands() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            "Brands",
            style: TextStyle(
              color: whiteColor,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "assets/images/brand1.png",
              "assets/images/brand2.png",
              "assets/images/brand3.png",
              "assets/images/brand4.png",
              "assets/images/brand5.png",
              "assets/images/brand6.png",
            ].map((pict) {
              return Container(
                width: 140,
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: whiteColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  pict,
                  fit: BoxFit.contain,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

// todo: about us section
  Container aboutUsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/shop_image.jpg",
              fit: BoxFit.cover,
              width: screenWidth(context) / 2,
              height: 500,
            ),
          ),
          const SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What is Ecommerce Web?",
                style: TextStyle(
                  color: darkBlueColor,
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: screenWidth(context) / 3,
                child: const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 5,
                ),
              ),
              const SizedBox(height: 40),
              CustomFilledButtonWidget(
                title: "Shop Now",
                widthButton: 120,
                heightButton: 50,
                backgroundButton: darkBlueColor,
                textButtonColor: whiteColor,
                textButtonSize: 14,
                textButtonFontWeight: FontWeight.w500,
                onPressed: () {
                  context.goNamed('shop');
                },
              )
            ],
          )
        ],
      ),
    );
  }

// todo: home footer
  Container homeFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth(context) / 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/logo_icon.png",
                          width: 50,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Ecommerce Web",
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ad minim veniam, quis nostrud exercitation ullamco laboris nisi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth(context) / 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Our Company",
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ad minim veniam, quis nostrud exercitation ullamco laboris nisi",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth(context) / 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Links",
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextButtonWidget(
                      title: "Home",
                      textColor: Colors.black,
                      textSize: 18,
                      textWeight: FontWeight.w200,
                      overlayColor: yellowColor,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                    CustomTextButtonWidget(
                      title: "Shop",
                      textColor: Colors.black,
                      textSize: 18,
                      textWeight: FontWeight.w200,
                      overlayColor: yellowColor,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                    CustomTextButtonWidget(
                      title: "Brands",
                      textColor: Colors.black,
                      textSize: 18,
                      textWeight: FontWeight.w200,
                      overlayColor: yellowColor,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                    CustomTextButtonWidget(
                      title: "About Us",
                      textColor: Colors.black,
                      textSize: 18,
                      textWeight: FontWeight.w200,
                      overlayColor: yellowColor,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(),
          const SizedBox(height: 40),
          Text(
            "Copyright 2024 Ecommerce Web. All Rights Reserved.",
            style: TextStyle(
              color: darkBlueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
