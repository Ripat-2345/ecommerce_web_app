import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_profile_display_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: "Home Store",
      color: whiteColor,
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Flex(
              direction: Axis.vertical,
              children: [
                // todo: appbar section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(100),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/icons/logo_icon.png",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Ecommerce Web",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomTextButtonWidget(
                            title: "Home",
                            textColor: whiteColor,
                            textSize: 16,
                            textWeight: FontWeight.w200,
                            overlayColor: blueColor,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          CustomTextButtonWidget(
                            title: "Shop",
                            textColor: whiteColor,
                            textSize: 16,
                            textWeight: FontWeight.w200,
                            overlayColor: blueColor,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          CustomTextButtonWidget(
                            title: "Brands",
                            textColor: whiteColor,
                            textSize: 16,
                            textWeight: FontWeight.w200,
                            overlayColor: blueColor,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          CustomTextButtonWidget(
                            title: "About Us",
                            textColor: whiteColor,
                            textSize: 16,
                            textWeight: FontWeight.w200,
                            overlayColor: blueColor,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            context.goNamed('profile');
                          },
                          child: const CustomProfileDisplayWidget()),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // todo: carousel section
                CarouselSlider(
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
                            image: DecorationImage(
                                image: AssetImage(pict), fit: BoxFit.cover),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 100),
                // todo: brand section
                Container(
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
                ),
                const SizedBox(height: 100),
                // todo:
                Container(
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
                            onPressed: () {},
                          )
                        ],
                      )
                    ],
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
