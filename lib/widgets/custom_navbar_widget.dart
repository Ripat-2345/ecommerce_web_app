import 'dart:convert';

import 'package:ecommerce_web_app/pages/home/home_page.dart';
import 'package:ecommerce_web_app/pages/shop/shop_page.dart';
import 'package:ecommerce_web_app/providers/product_provider.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_profile_display_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomNavbarWidget extends StatefulWidget {
  final String page;
  const CustomNavbarWidget({
    super.key,
    required this.page,
  });

  @override
  State<CustomNavbarWidget> createState() => _CustomNavbarWidgetState();
}

class _CustomNavbarWidgetState extends State<CustomNavbarWidget> {
  Map<String, dynamic>? authData;
  List? dataProducts;

  Widget? selectedContent;
  String titlePage = "Home";

  void _loadAuthDataFromStorage() async {
    final data = await readFromStorage('authData');
    setState(() {
      authData = jsonDecode(data!);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false)
          .getProducts(context: context)
          .then((value) {
        dataProducts = value!.dataProducts;
        if (widget.page == 'home') {
          setState(() {
            selectedContent = HomePage(dataProducts: dataProducts!);
          });
        } else if (widget.page == 'shop') {
          setState(() {
            selectedContent = ShopPage(dataProducts: dataProducts!);
          });
        }
      });
      _loadAuthDataFromStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: titlePage,
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
                // todo: navbar
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
                      // todo: home menu
                      Row(
                        children: [
                          CustomTextButtonWidget(
                            title: "Home",
                            textColor: whiteColor,
                            textSize: 16,
                            textWeight: FontWeight.w200,
                            overlayColor: blueColor,
                            onPressed: () {
                              setState(() {
                                selectedContent = HomePage(
                                  dataProducts: dataProducts,
                                );
                                titlePage = "Home";
                              });
                              // context.goNamed('home');
                            },
                          ),
                          const SizedBox(width: 20),
                          CustomTextButtonWidget(
                            title: "Shop",
                            textColor: whiteColor,
                            textSize: 16,
                            textWeight: FontWeight.w200,
                            overlayColor: blueColor,
                            onPressed: () {
                              setState(() {
                                selectedContent = ShopPage(
                                  dataProducts: dataProducts,
                                );
                                titlePage = "Shop";
                              });
                              // context.goNamed('shop');
                            },
                          ),
                          const SizedBox(width: 20),
                          CustomTextButtonWidget(
                            title: "Our Teams",
                            textColor: whiteColor,
                            textSize: 16,
                            textWeight: FontWeight.w200,
                            overlayColor: blueColor,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      authData != null
                          ? GestureDetector(
                              onTap: () {
                                context.goNamed(
                                  'dashboard',
                                  pathParameters: {'page': 'my-store'},
                                );
                              },
                              child: CustomProfileDisplayWidget(
                                username: authData!['data']['username'],
                                pictUrl: authData!['data']['avatar'],
                                idUser: authData!['data']['id'].toString(),
                              ),
                            )
                          : Row(
                              children: [
                                CustomFilledButtonWidget(
                                  title: 'Login',
                                  widthButton: 100,
                                  heightButton: 40,
                                  backgroundButton: yellowColor,
                                  textButtonColor: darkBlueColor,
                                  textButtonSize: 16,
                                  textButtonFontWeight: FontWeight.w600,
                                  onPressed: () {
                                    context.goNamed('login');
                                  },
                                ),
                                const SizedBox(width: 10),
                                CustomFilledButtonWidget(
                                  title: 'Register',
                                  widthButton: 110,
                                  heightButton: 40,
                                  backgroundButton: blueColor,
                                  textButtonColor: blueWhiteColor,
                                  textButtonSize: 16,
                                  textButtonFontWeight: FontWeight.w600,
                                  onPressed: () {
                                    context.goNamed('register');
                                  },
                                )
                              ],
                            ),
                    ],
                  ),
                ),
                // todo: content
                (selectedContent == null)
                    ? Center(
                        child: CircularProgressIndicator(
                          color: whiteColor,
                        ),
                      )
                    : selectedContent!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
