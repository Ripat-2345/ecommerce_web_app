import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  final String? token;
  const ChangePasswordPage({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Title(
      title: "Change Your Password",
      color: whiteColor,
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: Center(
          child: Container(
            width: 600,
            height: 400,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: darkBlueColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: CustomTextFieldWidget(title: "Password"),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: CustomTextFieldWidget(title: "Confirm Password"),
                ),
                const SizedBox(height: 20),
                CustomFilledButtonWidget(
                  title: "Change My Password",
                  widthButton: 400,
                  heightButton: 40,
                  backgroundButton: darkBlueColor,
                  textButtonColor: whiteColor,
                  textButtonSize: 16,
                  textButtonFontWeight: FontWeight.w600,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
