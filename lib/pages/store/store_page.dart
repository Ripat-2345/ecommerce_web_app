// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:html' as html;

import 'package:ecommerce_web_app/providers/product_provider.dart';
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

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
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
                Row(
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
                          authData!['data']['username'],
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            CustomFilledButtonWidget(
                              title: "Edit Profile",
                              widthButton: 120,
                              heightButton: 35,
                              backgroundButton: blueColor,
                              textButtonColor: whiteColor,
                              textButtonSize: 14,
                              textButtonFontWeight: FontWeight.w500,
                              onPressed: () {},
                            ),
                            const SizedBox(width: 10),
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
                      ],
                    ),
                    const Spacer(),
                    // todo: add product
                    CustomFilledButtonWidget(
                      title: "Add Product",
                      widthButton: 150,
                      heightButton: 50,
                      backgroundButton: yellowColor,
                      textButtonColor: darkBlueColor,
                      textButtonSize: 18,
                      textButtonFontWeight: FontWeight.w800,
                      onPressed: () {
                        addProduct(context, productProvider);
                      },
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Text(
                  'List Of My Products',
                  style: TextStyle(
                    color: darkBlueColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),
                // todo: display list of user product
                FutureBuilder(
                  future: productProvider.getProductsByIdUser(
                    context: context,
                    idUser: authData!['data']['id'].toString(),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
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
                                headingRowColor:
                                    MaterialStatePropertyAll(darkBlueColor),
                                headingTextStyle: TextStyle(
                                  color: whiteColor,
                                ),
                                dataRowMaxHeight: 100,
                                columns: const [
                                  DataColumn(
                                    label: Text('ID'),
                                  ),
                                  DataColumn(
                                    label: Text('Image'),
                                  ),
                                  DataColumn(
                                    label: Text('Name'),
                                  ),
                                  DataColumn(
                                    label: Text('Description'),
                                  ),
                                  DataColumn(
                                    label: Text('Price'),
                                  ),
                                  DataColumn(
                                    label: Text('Action'),
                                  ),
                                ],
                                rows: snapshot.data!.dataProducts.map((data) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text('${no++}')),
                                      DataCell(
                                        Image.network(
                                          '$baseUrl/images/${data['picture']!.split("\\")[1]}',
                                          width: 300,
                                          height: 100,
                                        ),
                                      ),
                                      DataCell(Text(data['name'])),
                                      DataCell(Text(data['description'])),
                                      DataCell(Text(data['price'].toString())),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
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
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // todo: add product function
  void addProduct(BuildContext context, ProductProvider productProvider) {
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
                html.window.location.reload();
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
                html.window.location.reload();
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
  void deleteProduct(ProductProvider productProvider, data) {
    productProvider.deleteProduct(
      context: context,
      idProduct: data['id'].toString(),
    );
    html.window.location.reload();
  }
}
