import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: "Register",
      color: whiteColor,
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: Center(
          child: Container(
            width: 900,
            height: (screenWidth(context) >= laptopScreenSize)
                ? 800
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
                          "Let us know you!",
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Icon(
                          Icons.text_snippet_rounded,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // todo: form register
                      Animate(
                        effects: [
                          MoveEffect(
                            duration: const Duration(milliseconds: 500),
                            begin: (screenWidth(context) >= laptopScreenSize)
                                ? const Offset(20, 0)
                                : const Offset(0, 20),
                          )
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // todo: email field
                            const CustomTextFieldWidget(
                              title: "Your Name",
                            ),
                            const SizedBox(height: 20),
                            // todo: username field
                            const CustomTextFieldWidget(
                              title: "Username",
                            ),
                            const SizedBox(height: 20),
                            // todo: email field
                            const CustomTextFieldWidget(
                              title: "Email",
                            ),
                            const SizedBox(height: 20),
                            // todo: password field
                            const CustomTextFieldWidget(
                              title: "Password",
                            ),
                            const SizedBox(height: 20),
                            // todo: avatar field
                            const CustomTextFieldWidget(
                              title: "Your Avatar",
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
                                title: "Registration",
                                onPressed: () => context.goNamed('login'),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have account, ",
                                    style: TextStyle(
                                      color: blueColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  CustomTextButtonWidget(
                                    title: "Login!",
                                    textColor: darkBlueColor,
                                    textSize: 16,
                                    textWeight: FontWeight.w400,
                                    onPressed: () => context.goNamed('login'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      (screenWidth(context) >= laptopScreenSize)
                          ? Animate(
                              effects: const [
                                MoveEffect(
                                  duration: Duration(milliseconds: 500),
                                  begin: Offset(-20, 0),
                                ),
                              ],
                              child: Image.asset(
                                "assets/images/register_image.png",
                                width: 400,
                              ),
                            )
                          : const SizedBox(),
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
