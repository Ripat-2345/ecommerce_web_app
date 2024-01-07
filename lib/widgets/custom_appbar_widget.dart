import 'dart:convert';

import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_profile_display_widget.dart';
import 'package:flutter/material.dart';

class CustomAppbarWidget extends StatefulWidget {
  const CustomAppbarWidget({super.key});

  @override
  State<CustomAppbarWidget> createState() => _CustomAppbarWidgetState();
}

class _CustomAppbarWidgetState extends State<CustomAppbarWidget> {
  Map<String, dynamic>? authData;

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
      _loadAuthDataFromStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: (screenWidth(context) >= laptopScreenSize)
          ? Axis.horizontal
          : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 400,
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search here....",
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 24,
                color: darkBlueColor,
              ),
              filled: true,
              fillColor: whiteColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: blueColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: darkBlueColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        CustomProfileDisplayWidget(
          username: authData!['data']['username'],
          pictUrl: authData!['data']['avatar'],
        ),
      ],
    );
  }
}
