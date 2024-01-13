// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:ecommerce_web_app/providers/product_provider.dart';
import 'package:ecommerce_web_app/providers/user_provider.dart';
import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  // todo: product property
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  XFile? picture;

  bool isValidatedFormProduct(BuildContext context) {
    if (productNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty) {
      snackBarInfo(context, "Field Tidak Boleh Kosong");
      return false;
    } else {
      return true;
    }
  }

  // todo: user property
  TextEditingController? nameController;
  TextEditingController? usernameController;
  TextEditingController? emailController;

  XFile? userImage;

  bool isValidatedFormUser(BuildContext context) {
    if (nameController!.text.isEmpty ||
        usernameController!.text.isEmpty ||
        emailController!.text.isEmpty) {
      snackBarInfo(context, "Field Tidak Boleh Kosong");
      return false;
    } else {
      return true;
    }
  }

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isValidatedChangePasswordUser(BuildContext context) {
    if (newPasswordController.text.isEmpty ||
        currentPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      snackBarInfo(context, "Field Tidak Boleh Kosong");
      return false;
    } else {
      return true;
    }
  }

  Map<String, dynamic>? authData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final data = await readFromStorage('authData');
      setState(() {
        authData = jsonDecode(data!);
      });
    });
  }

  List<DataColumn> headingDataTable = const [
    DataColumn(
      label: Expanded(
        child: Text(
          'ID',
          textAlign: TextAlign.center,
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Text(
          'Image',
          textAlign: TextAlign.center,
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Text(
          'Name',
          textAlign: TextAlign.center,
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Text(
          'Description',
          textAlign: TextAlign.center,
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Text(
          'Price',
          textAlign: TextAlign.center,
        ),
      ),
    ),
    DataColumn(
      label: Expanded(
        child: Text(
          'Action',
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
          right: 20,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // todo: profile user
                profileUser(context, authData, userProvider),
                const SizedBox(height: 50),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'List Of My Products',
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),

                    // todo: add product
                    CustomFilledButtonWidget(
                      title: "Add Product",
                      widthButton: 150,
                      heightButton: 50,
                      backgroundButton: Colors.green,
                      textButtonColor: whiteColor,
                      textButtonSize: 18,
                      textButtonFontWeight: FontWeight.w500,
                      onPressed: () {
                        addProduct(context, productProvider);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // todo: display list of user product
                FutureBuilder(
                  future: productProvider.getProductsByIdUser(
                    context: context,
                    idUser: authData!['data']['id'].toString(),
                  ),
                  builder: (context, snapshot) {
                    var no = 1;
                    return snapshot.data!.dataProducts.isEmpty
                        ? Center(
                            child: Text(
                              "Tidak Ada Product!",
                              style: TextStyle(
                                color: darkBlueColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: DataTable(
                              headingRowColor: MaterialStatePropertyAll(
                                darkBlueColor,
                              ),
                              headingTextStyle: TextStyle(color: whiteColor),
                              dataRowMaxHeight: 100,
                              columns: headingDataTable,
                              rows: snapshot.data!.dataProducts.map((data) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Center(
                                        child: Text(
                                          '${no++}',
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Image.network(
                                          '$baseUrl/images/${data['picture']!.split("\\")[1]}',
                                          width: 300,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          data['name'],
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          data['description'],
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          data['price'].toString(),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomFilledButtonWidget(
                                              title: "Edit",
                                              widthButton: 80,
                                              heightButton: 40,
                                              backgroundButton: blueColor,
                                              textButtonColor: whiteColor,
                                              textButtonSize: 14,
                                              textButtonFontWeight:
                                                  FontWeight.w500,
                                              onPressed: () {
                                                editProduct(
                                                  context,
                                                  data,
                                                  productProvider,
                                                );
                                              },
                                            ),
                                            const SizedBox(width: 10),
                                            CustomFilledButtonWidget(
                                              title: "Hapus",
                                              widthButton: 80,
                                              heightButton: 40,
                                              backgroundButton: Colors.red,
                                              textButtonColor: whiteColor,
                                              textButtonSize: 14,
                                              textButtonFontWeight:
                                                  FontWeight.w500,
                                              onPressed: () async {
                                                deleteProduct(
                                                  productProvider,
                                                  data,
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // todo: Profile User
  Container profileUser(
    BuildContext context,
    Map<String, dynamic>? authData,
    UserProvider? userProvider,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: blueWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              "$baseUrl/images/${authData!['data']['avatar'].split("\\")[1]}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authData['data']['name'],
                style: TextStyle(
                  color: darkBlueColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  Text(
                    authData['data']['username'],
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    " - ",
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    authData['data']['email'],
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CustomFilledButtonWidget(
                    title: "Edit Profile",
                    widthButton: 85,
                    heightButton: 30,
                    backgroundButton: blueColor,
                    textButtonColor: whiteColor,
                    textButtonSize: 14,
                    textButtonFontWeight: FontWeight.w500,
                    onPressed: () {
                      setState(() {
                        nameController = TextEditingController(
                            text: authData['data']['name']);
                        usernameController = TextEditingController(
                            text: authData['data']['username']);
                        emailController = TextEditingController(
                            text: authData['data']['email']);
                        userImage = XFile('');
                      });
                      customShowDialog(
                        context: context,
                        title: "Edit Profile",
                        content: StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFieldWidget(
                                  title: "Name",
                                  controller: nameController,
                                  width: double.infinity,
                                ),
                                const SizedBox(height: 20),
                                CustomTextFieldWidget(
                                  title: "Username",
                                  controller: usernameController,
                                  width: double.infinity,
                                ),
                                const SizedBox(height: 20),
                                CustomTextFieldWidget(
                                  title: "Email",
                                  controller: emailController,
                                  width: double.infinity,
                                ),
                                const SizedBox(height: 20),
                                Flex(
                                  direction: Axis.vertical,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomFilledButtonWidget(
                                      title: "Change Profile Image",
                                      widthButton: 160,
                                      heightButton: 40,
                                      backgroundButton: yellowColor,
                                      textButtonColor: darkBlueColor,
                                      textButtonSize: 14,
                                      textButtonFontWeight: FontWeight.w600,
                                      onPressed: () async {
                                        var image = await takeImageFromDevice();
                                        setState(() {
                                          if (image == null) {
                                            image = XFile('');
                                            userImage = image;
                                          } else {
                                            userImage = image;
                                          }
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        userImage!.path != ''
                                            ? userImage!.path
                                            : "$baseUrl/images/${authData['data']['avatar'].split("\\")[1]}",
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        actionList: [
                          CustomFilledButtonWidget(
                            title: "Change",
                            widthButton: 80,
                            heightButton: 40,
                            backgroundButton: darkBlueColor,
                            textButtonColor: whiteColor,
                            textButtonSize: 14,
                            textButtonFontWeight: FontWeight.w500,
                            onPressed: () async {
                              if (isValidatedFormUser(context)) {
                                await userProvider!
                                    .updateBioUser(
                                  context: context,
                                  name: nameController!.text,
                                  username: usernameController!.text,
                                  email: emailController!.text,
                                  avatar: userImage,
                                  idUser: authData['data']['id'].toString(),
                                )
                                    .then((_) {
                                  context.pop();
                                  setState(() {});
                                });
                              }
                            },
                          ),
                          CustomFilledButtonWidget(
                            title: "Cancel",
                            widthButton: 80,
                            heightButton: 40,
                            backgroundButton: Colors.red,
                            textButtonColor: whiteColor,
                            textButtonSize: 14,
                            textButtonFontWeight: FontWeight.w500,
                            onPressed: () async {
                              context.pop();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  CustomFilledButtonWidget(
                    title: "Edit Password",
                    widthButton: 110,
                    heightButton: 30,
                    backgroundButton: darkBlueColor,
                    textButtonColor: whiteColor,
                    textButtonSize: 14,
                    textButtonFontWeight: FontWeight.w500,
                    onPressed: () {
                      customShowDialog(
                        context: context,
                        title: "Change Password",
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextFieldWidget(
                              title: "Current Password",
                              controller: currentPasswordController,
                              obscureText: true,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 20),
                            CustomTextFieldWidget(
                              title: "New Password",
                              controller: newPasswordController,
                              obscureText: true,
                              width: double.infinity,
                            ),
                            const SizedBox(height: 20),
                            CustomTextFieldWidget(
                              title: "Confirm Password",
                              controller: confirmPasswordController,
                              obscureText: true,
                              width: double.infinity,
                            ),
                          ],
                        ),
                        actionList: [
                          CustomFilledButtonWidget(
                            title: "Change",
                            widthButton: 80,
                            heightButton: 40,
                            backgroundButton: darkBlueColor,
                            textButtonColor: whiteColor,
                            textButtonSize: 14,
                            textButtonFontWeight: FontWeight.w500,
                            onPressed: () async {
                              if (isValidatedChangePasswordUser(context)) {
                                if (newPasswordController.text ==
                                    confirmPasswordController.text) {
                                  await userProvider!.updatePasswordUser(
                                    context: context,
                                    idUser: authData['data']['id'].toString(),
                                    currentPassword:
                                        currentPasswordController.text,
                                    password: confirmPasswordController.text,
                                  );
                                } else {
                                  snackBarInfo(
                                    context,
                                    "Confirm Password Salah",
                                  );
                                }
                              }
                            },
                          ),
                          CustomFilledButtonWidget(
                            title: "Cancel",
                            widthButton: 80,
                            heightButton: 40,
                            backgroundButton: Colors.red,
                            textButtonColor: whiteColor,
                            textButtonSize: 14,
                            textButtonFontWeight: FontWeight.w500,
                            onPressed: () async {
                              context.pop();
                            },
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          CustomFilledButtonWidget(
            title: "Logout",
            widthButton: 80,
            heightButton: 35,
            backgroundButton: Colors.red,
            textButtonColor: whiteColor,
            textButtonSize: 14,
            textButtonFontWeight: FontWeight.w500,
            onPressed: () async {
              await removeFromStorage('authData');
              context.goNamed('home');
            },
          ),
        ],
      ),
    );
  }

  // todo: add product function
  void addProduct(BuildContext context, ProductProvider productProvider) {
    setState(() {
      productNameController.text = "";
      descriptionController.text = "";
      priceController.text = "";
      picture = XFile('');
    });
    return customShowDialog(
      context: context,
      title: "Add Product",
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldWidget(
                title: "Product Name",
                controller: productNameController,
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                title: "Description",
                controller: descriptionController,
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                title: "Price",
                controller: priceController,
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFilledButtonWidget(
                    title: "Upload Image",
                    widthButton: 110,
                    heightButton: 40,
                    backgroundButton: yellowColor,
                    textButtonColor: darkBlueColor,
                    textButtonSize: 14,
                    textButtonFontWeight: FontWeight.w600,
                    onPressed: () async {
                      var image = await takeImageFromDevice();
                      setState(() {
                        if (image == null) {
                          image = XFile('');
                          picture = image;
                        } else {
                          picture = image;
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  picture != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: picture!.path != ''
                              ? Image.network(
                                  picture!.path,
                                  width: 200,
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          );
        },
      ),
      actionList: [
        CustomFilledButtonWidget(
          title: "Add",
          widthButton: 80,
          heightButton: 40,
          backgroundButton: Colors.green,
          textButtonColor: whiteColor,
          textButtonSize: 14,
          textButtonFontWeight: FontWeight.w500,
          onPressed: () async {
            if (isValidatedFormProduct(context)) {
              await productProvider
                  .addProduct(
                context: context,
                productName: productNameController.text,
                description: descriptionController.text,
                price: priceController.text,
                picture: picture,
                idUser: authData!['data']['id'].toString(),
              )
                  .then((_) {
                context.pop();
                setState(() {});
              });
            }
          },
        ),
        CustomFilledButtonWidget(
          title: "Cancel",
          widthButton: 80,
          heightButton: 40,
          backgroundButton: Colors.red,
          textButtonColor: whiteColor,
          textButtonSize: 14,
          textButtonFontWeight: FontWeight.w500,
          onPressed: () async {
            context.pop();
          },
        )
      ],
    );
  }

  // todo: edit product function
  void editProduct(
    BuildContext context,
    data,
    ProductProvider productProvider,
  ) {
    setState(() {
      productNameController.text = data['name'];
      descriptionController.text = data['description'];
      priceController.text = data['price'].toString();
      picture = XFile('');
    });
    return customShowDialog(
      context: context,
      title: "Edit Product",
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldWidget(
                title: "Product Name",
                controller: productNameController,
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                title: "Description",
                controller: descriptionController,
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                title: "Price",
                controller: priceController,
                width: double.infinity,
              ),
              const SizedBox(height: 20),
              Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFilledButtonWidget(
                    title: "Upload Image",
                    widthButton: 110,
                    heightButton: 40,
                    backgroundButton: yellowColor,
                    textButtonColor: darkBlueColor,
                    textButtonSize: 14,
                    textButtonFontWeight: FontWeight.w600,
                    onPressed: () async {
                      var image = await takeImageFromDevice();
                      setState(() {
                        if (image == null) {
                          image = XFile('');
                          picture = image;
                        } else {
                          picture = image;
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      picture!.path != ''
                          ? picture!.path
                          : "$baseUrl/images/${data['picture'].split("\\")[1]}",
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
      actionList: [
        CustomFilledButtonWidget(
          title: "Edit",
          widthButton: 80,
          heightButton: 40,
          backgroundButton: blueColor,
          textButtonColor: whiteColor,
          textButtonSize: 14,
          textButtonFontWeight: FontWeight.w500,
          onPressed: () async {
            if (isValidatedFormProduct(context)) {
              await productProvider
                  .editProduct(
                context: context,
                idProduct: data['id'].toString(),
                productName: productNameController.text,
                description: descriptionController.text,
                price: priceController.text,
                picture: picture,
                idUser: authData!['data']['id'].toString(),
              )
                  .then((_) {
                context.pop();
                setState(() {});
              });
            }
          },
        ),
        CustomFilledButtonWidget(
          title: "Cancel",
          widthButton: 80,
          heightButton: 40,
          backgroundButton: Colors.red,
          textButtonColor: whiteColor,
          textButtonSize: 14,
          textButtonFontWeight: FontWeight.w500,
          onPressed: () async {
            context.pop();
          },
        )
      ],
    );
  }

  // todo: delete product function
  void deleteProduct(ProductProvider productProvider, data) async {
    await productProvider
        .deleteProduct(
      context: context,
      idProduct: data['id'].toString(),
    )
        .then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();

    nameController!.dispose();
    usernameController!.dispose();
    emailController!.dispose();
  }
}
