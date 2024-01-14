import 'package:ecommerce_web_app/pages/cart/cart_page.dart';
import 'package:ecommerce_web_app/pages/store/store_page.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomSidebarWidget extends StatefulWidget {
  final String page;
  const CustomSidebarWidget({super.key, required this.page});

  @override
  State<CustomSidebarWidget> createState() => _CustomSidebarWidgetState();
}

class _CustomSidebarWidgetState extends State<CustomSidebarWidget> {
  Map pages = {
    'my-store': {
      'index': 0,
      'title': 'my-store',
      'label': 'My Store',
      'icon': Icons.store_rounded,
      'page': const StorePage(),
    },
    'my-cart': {
      'index': 1,
      'title': 'my-cart',
      'label': 'My Cart',
      'icon': Icons.shopping_cart_rounded,
      'page': const CartPage(),
    },
  };

  List<SidebarXItem> listItems() {
    List<SidebarXItem> sidebarlist = [];
    pages.forEach((key, item) {
      sidebarlist.add(
        SidebarXItem(
          icon: item['icon'],
          label: item['label'],
          onTap: () {
            context.goNamed(
              'dashboard',
              pathParameters: {'page': item['title']},
            );
          },
        ),
      );
    });
    return sidebarlist;
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: pages[widget.page]['label'],
      color: whiteColor,
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: Row(
          children: [
            SidebarX(
              controller: SidebarXController(
                selectedIndex: pages[widget.page]['index'],
                extended: true,
              ),
              headerBuilder: (context, extended) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => context.goNamed('home'),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/logo_icon.png",
                            width: 50,
                          ),
                          const SizedBox(width: 10),
                          (extended)
                              ? Text(
                                  "Ecommerce Web",
                                  style: TextStyle(
                                    color: darkBlueColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                );
              },
              headerDivider: Divider(color: darkBlueColor, thickness: 2),
              // todo: theme sidebar open
              extendedTheme: SidebarXTheme(
                width: 250,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemMargin: const EdgeInsets.symmetric(vertical: 10),
                textStyle: TextStyle(
                  color: blueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                hoverTextStyle: TextStyle(
                  color: blueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                iconTheme: IconThemeData(
                  size: 30,
                  color: blueColor,
                ),
                selectedIconTheme: IconThemeData(
                  size: 30,
                  color: darkBlueColor,
                ),
                selectedTextStyle: TextStyle(
                  color: darkBlueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // todo: theme sidebar close
              theme: SidebarXTheme(
                width: 60,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                iconTheme: IconThemeData(
                  size: 30,
                  color: blueColor,
                ),
                selectedIconTheme: IconThemeData(
                  size: 30,
                  color: darkBlueColor,
                ),
                itemTextPadding: const EdgeInsets.symmetric(horizontal: 10),
                selectedItemTextPadding:
                    const EdgeInsets.symmetric(horizontal: 10),
              ),
              items: listItems(),
            ),
            pages[widget.page]['page'],
          ],
        ),
      ),
    );
  }
}
