import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomSidebarWidget extends StatelessWidget {
  const CustomSidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: SidebarXController(selectedIndex: 0, extended: true),
      headerBuilder: (context, extended) {
        return Padding(
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
        selectedItemTextPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      items: const [
        SidebarXItem(
          icon: Icons.dashboard_rounded,
          label: 'Marketplace',
        ),
        SidebarXItem(
          icon: Icons.store_rounded,
          label: 'My Store',
        ),
        SidebarXItem(
          icon: Icons.shopping_cart_rounded,
          label: 'My Cart',
        ),
        SidebarXItem(
          icon: Icons.manage_accounts_rounded,
          label: 'Profile',
        ),
      ],
    );
  }
}
