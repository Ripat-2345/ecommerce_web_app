import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: "Login",
      color: whiteColor,
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: Center(
          child: Container(
            width: 900,
            height: (screenWidth(context) >= laptopScreenSize)
                ? 500
                : double.infinity,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(left: 22, top: 40, right: 22),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Animate(
                    effects: const [
                      MoveEffect(
                        duration: Duration(milliseconds: 500),
                        begin: Offset(0, -20),
                      ),
                    ],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Let's Shopping",
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Icon(
                          Icons.shopping_cart,
                          color: yellowColor,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Flex(
                    direction: (screenWidth(context) >= laptopScreenSize)
                        ? Axis.horizontal
                        : Axis.vertical,
                    crossAxisAlignment:
                        (screenWidth(context) >= laptopScreenSize)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Animate(
                        effects: [
                          MoveEffect(
                            duration: const Duration(milliseconds: 500),
                            begin: (screenWidth(context) >= laptopScreenSize)
                                ? const Offset(20, 0)
                                : const Offset(0, 20),
                          )
                        ],
                        child: Image.asset(
                          "assets/images/web_store_image.png",
                          width: (screenWidth(context) >= laptopScreenSize)
                              ? 400
                              : (screenWidth(context) >= 425)
                                  ? 350
                                  : screenWidth(context),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // todo: form login
                      Animate(
                        effects: [
                          MoveEffect(
                            duration: const Duration(milliseconds: 500),
                            begin: (screenWidth(context) >= laptopScreenSize)
                                ? const Offset(-20, 0)
                                : const Offset(0, 20),
                          ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // todo: email field
                            const CustomTextFieldWidget(
                              title: "Your Email",
                            ),
                            const SizedBox(height: 20),
                            // todo: password field
                            const CustomTextFieldWidget(
                              title: "Password",
                            ),
                            const SizedBox(height: 10),
                            // todo: forgot password link
                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomTextButtonWidget(
                                title: "Forgot Password?",
                                textColor: darkBlueColor,
                                textSize: 16,
                                textWeight: FontWeight.w400,
                                onPressed: () {
                                  context.goNamed('forgot-password');
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomFilledButtonWidget(
                                widthButton: 400,
                                heightButton: 50,
                                backgroundButton: darkBlueColor,
                                textButtonColor: whiteColor,
                                textButtonSize: 16,
                                textButtonFontWeight: FontWeight.w500,
                                title: "Login",
                                onPressed: () => context.goNamed('home'),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have account, ",
                                    style: TextStyle(
                                      color: blueColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  CustomTextButtonWidget(
                                    title: "Register!",
                                    textColor: darkBlueColor,
                                    textSize: 16,
                                    textWeight: FontWeight.w400,
                                    onPressed: () =>
                                        context.goNamed('register'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
