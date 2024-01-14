import 'package:ecommerce_web_app/providers/auth_provider.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    return Title(
      title: "Forgot Password",
      color: whiteColor,
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: Center(
          child: Container(
            width: 600,
            height: 280,
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
                Center(
                  child: CustomTextFieldWidget(
                    controller: emailController,
                    obscureText: true,
                    title: "Your Email",
                  ),
                ),
                const SizedBox(height: 20),
                CustomFilledButtonWidget(
                  title: "Send",
                  widthButton: 400,
                  heightButton: 40,
                  backgroundButton: darkBlueColor,
                  textButtonColor: whiteColor,
                  textButtonSize: 16,
                  textButtonFontWeight: FontWeight.w600,
                  onPressed: () async {
                    await authProvider.forgotPassword(
                      context: context,
                      email: emailController.text,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
