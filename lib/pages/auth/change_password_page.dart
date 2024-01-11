import 'package:ecommerce_web_app/providers/auth_provider.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  final String? token;
  const ChangePasswordPage({
    super.key,
    required this.token,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? token;

  @override
  void initState() {
    super.initState();
    setState(() {
      token = widget.token;
    });
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

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
                    "Change Your Password",
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
                    controller: passwordController,
                    title: "Password",
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomTextFieldWidget(
                    controller: confirmPasswordController,
                    title: "Confirm Password",
                  ),
                ),
                const SizedBox(height: 20),
                CustomFilledButtonWidget(
                  title: "Change Password",
                  widthButton: 500,
                  heightButton: 50,
                  backgroundButton: darkBlueColor,
                  textButtonColor: whiteColor,
                  textButtonSize: 16,
                  textButtonFontWeight: FontWeight.w600,
                  onPressed: () async {
                    await authProvider.changePassword(
                      context: context,
                      password: passwordController.text,
                      confirmPassword: confirmPasswordController.text,
                      token: token,
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
