// ignore_for_file: use_build_context_synchronously
import 'dart:html' as html;

import 'package:ecommerce_web_app/providers/cart_provider.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomProfileDisplayWidget extends StatefulWidget {
  final String username;
  final String pictUrl;
  final String idUser;
  const CustomProfileDisplayWidget({
    super.key,
    required this.username,
    required this.pictUrl,
    required this.idUser,
  });

  @override
  State<CustomProfileDisplayWidget> createState() =>
      _CustomProfileDisplayWidgetState();
}

class _CustomProfileDisplayWidgetState
    extends State<CustomProfileDisplayWidget> {
  String? cartItem;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartProvider>(context, listen: false)
          .getCartsByIdUser(context: context, idUser: widget.idUser)
          .then((data) {
        setState(() {
          cartItem = data!.dataCarts.length.toString();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.username.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Howday, ${widget.username}",
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  CustomFilledButtonWidget(
                    title: "Logout",
                    widthButton: 60,
                    heightButton: 30,
                    backgroundButton: Colors.red,
                    textButtonColor: whiteColor,
                    textButtonSize: 14,
                    textButtonFontWeight: FontWeight.w500,
                    onPressed: () async {
                      await removeFromStorage('authData');
                      context.goNamed('home');
                      html.window.location.reload();
                    },
                  ),
                  const SizedBox(width: 10),
                  Stack(
                    children: [
                      CustomIconButtonWidget(
                        onTap: () {
                          context.goNamed(
                            'dashboard',
                            pathParameters: {'page': 'my-cart'},
                          );
                        },
                        iconButton: Icons.shopping_cart_rounded,
                        iconSize: 24,
                        iconColor: darkBlueColor,
                        width: 40,
                        height: 30,
                        color: whiteColor,
                      ),
                      cartItem != null
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: yellowColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    cartItem!,
                                    style: TextStyle(
                                      color: darkBlueColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ],
          )
        else
          const SizedBox(),
        const SizedBox(width: 10),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: widget.pictUrl.isEmpty
                    ? const AssetImage("assets/images/user.png")
                        as ImageProvider
                    : NetworkImage(
                        "$baseUrl/images/${widget.pictUrl.split('\\')[1]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
