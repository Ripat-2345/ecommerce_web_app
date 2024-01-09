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
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String? idUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final data = await readFromStorage('authData');
      setState(() {
        idUser = jsonDecode(data!)['data']['id'].toString();
      });
    });
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
                      child: Image.asset(
                        "assets/images/user.png",
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
                          "Karina Anak Sapa",
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
                    CustomFilledButtonWidget(
                      title: "Add Product",
                      widthButton: 150,
                      heightButton: 50,
                      backgroundButton: yellowColor,
                      textButtonColor: darkBlueColor,
                      textButtonSize: 18,
                      textButtonFontWeight: FontWeight.w800,
                      onPressed: () {
                        customShowDialog(
                          context: context,
                          title: "Tambah Product",
                          content: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFieldWidget(
                                title: "Product Name",
                              ),
                              CustomTextFieldWidget(
                                title: "Description Product",
                              ),
                              CustomTextFieldWidget(
                                title: "Product Price",
                              ),
                              CustomTextFieldWidget(
                                title: "Product Image",
                              ),
                            ],
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
                              onPressed: () {},
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
                FutureBuilder(
                  future: productProvider.getProductsByIdUser(
                      context: context, idUser: idUser),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var no = 1;
                      return SizedBox(
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
                                    '$baseUrl/${data['picture']!}',
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
                                          textButtonFontWeight: FontWeight.w500,
                                          onPressed: () {},
                                        ),
                                        const SizedBox(width: 10),
                                        CustomFilledButtonWidget(
                                          title: "Hapus",
                                          widthButton: 80,
                                          heightButton: 40,
                                          backgroundButton: Colors.red,
                                          textButtonColor: whiteColor,
                                          textButtonSize: 14,
                                          textButtonFontWeight: FontWeight.w500,
                                          onPressed: () async {
                                            productProvider.deleteProduct(
                                              context: context,
                                              idProduct: data['id'].toString(),
                                            );
                                            html.window.location.reload();
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
}
