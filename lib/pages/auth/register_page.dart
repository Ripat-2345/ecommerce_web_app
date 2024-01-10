import 'package:ecommerce_web_app/providers/auth_provider.dart';
import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  XFile? avatar;

  bool isValidatedFormRegister(BuildContext context) {
    if (nameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      snackBarInfo(context, "Field tidak boleh kosong!");
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

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
                            CustomTextFieldWidget(
                              controller: nameController,
                              title: "Your Name",
                            ),
                            const SizedBox(height: 20),
                            // todo: username field
                            CustomTextFieldWidget(
                              controller: usernameController,
                              title: "Username",
                            ),
                            const SizedBox(height: 20),
                            // todo: email field
                            CustomTextFieldWidget(
                              controller: emailController,
                              title: "Email",
                            ),
                            const SizedBox(height: 20),
                            // todo: password field
                            CustomTextFieldWidget(
                              controller: passwordController,
                              obscureText: true,
                              title: "Password",
                            ),
                            const SizedBox(height: 20),
                            // todo: avatar field
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                avatar != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          avatar!.path,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const SizedBox(),
                                const SizedBox(width: 50),
                                CustomFilledButtonWidget(
                                  title: "Upload Avatar",
                                  widthButton: 165,
                                  heightButton: 40,
                                  backgroundButton: yellowColor,
                                  textButtonColor: darkBlueColor,
                                  textButtonSize: 18,
                                  textButtonFontWeight: FontWeight.w600,
                                  onPressed: () async {
                                    var image = await takeImageFromDevice();
                                    setState(() {
                                      avatar = image;
                                    });
                                  },
                                ),
                              ],
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
                                onPressed: () async {
                                  await authProvider.register(
                                    context: context,
                                    name: nameController.text,
                                    username: usernameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    avatar: avatar,
                                  );
                                },
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
