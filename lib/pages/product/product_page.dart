// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:ecommerce_web_app/providers/cart_provider.dart';
import 'package:ecommerce_web_app/providers/comment_provider.dart';
import 'package:ecommerce_web_app/providers/product_provider.dart';
import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_comment_item_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_icon_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final String product;
  const ProductPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  TextEditingController commentController = TextEditingController();
  int qty = 1;
  Map<String, dynamic>? authData;

  List? detailProduct;
  void _loadAuthDataFromStorage() async {
    final data = await readFromStorage('authData');

    setState(() {
      authData = jsonDecode(data!);
    });
  }

  @override
  void initState() {
    super.initState();
    detailProduct = widget.product.split("+");
    _loadAuthDataFromStorage();
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    var commentProvider = Provider.of<CommentProvider>(context);
    var cartProvider = Provider.of<CartProvider>(context);

    return Title(
      title: detailProduct![0],
      color: whiteColor,
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: FutureBuilder(
          future: productProvider.getDetailProduct(id: detailProduct![1]),
          builder: (context, snapshot) {
            var dataProduct = snapshot.data!.dataProduct;
            return Center(
              child: Container(
                width: 1200,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomIconButtonWidget(
                        onTap: () {
                          context.goNamed('shop');
                        },
                        iconButton: Icons.arrow_back_ios_rounded,
                        iconSize: 50,
                        iconColor: darkBlueColor,
                        width: 50,
                        height: 50,
                        color: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 50),
                    // todo: product section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InteractiveViewer(
                            child: Image.network(
                              '$baseUrl/images/${dataProduct['picture'].split("\\")[1]}',
                              width: 500,
                              height: 500,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataProduct['name'],
                              style: TextStyle(
                                  color: darkBlueColor,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 3,
                            ),
                            SizedBox(
                              width: 400,
                              child: Text(
                                dataProduct['description'],
                                style: TextStyle(
                                  color: darkBlueColor,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 3,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Rp.${dataProduct['price'] * qty}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomIconButtonWidget(
                                      onTap: () {
                                        if (qty > 1) {
                                          setState(() => qty--);
                                        }
                                      },
                                      iconButton: Icons.remove_rounded,
                                      iconSize: 24,
                                      iconColor: darkBlueColor,
                                      width: 50,
                                      height: 50,
                                      color: yellowColor,
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      qty.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    CustomIconButtonWidget(
                                      onTap: () {
                                        setState(() => qty++);
                                      },
                                      iconButton: Icons.add_rounded,
                                      iconSize: 24,
                                      iconColor: yellowColor,
                                      width: 50,
                                      height: 50,
                                      color: darkBlueColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                CustomFilledButtonWidget(
                                  title: "Add to Cart",
                                  widthButton: 150,
                                  heightButton: 50,
                                  backgroundButton: darkBlueColor,
                                  textButtonColor: whiteColor,
                                  textButtonSize: 16,
                                  textButtonFontWeight: FontWeight.w500,
                                  onPressed: () async {
                                    final data =
                                        await readFromStorage('authData');
                                    if (data == null) {
                                      snackBarInfo(
                                        context,
                                        "Anda Harus Login Terlebih Dahulu!",
                                      );
                                    } else {
                                      await cartProvider.addProductToCart(
                                        context: context,
                                        idProduct: dataProduct['id'].toString(),
                                        idUser:
                                            authData!['data']['id'].toString(),
                                        quantity: qty.toString(),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    // todo: comment section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Comments Of Product",
                          style: TextStyle(
                            color: darkBlueColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        CustomFilledButtonWidget(
                          title: "Add Comment",
                          widthButton: 140,
                          heightButton: 40,
                          backgroundButton: yellowColor,
                          textButtonColor: darkBlueColor,
                          textButtonSize: 18,
                          textButtonFontWeight: FontWeight.w600,
                          onPressed: () async {
                            final isLogin = await readFromStorage('authData');
                            if (isLogin == null) {
                              snackBarInfo(
                                context,
                                "Anda Harus Login Terlebih Dahulu!",
                              );
                            } else {
                              setState(() {
                                commentController = TextEditingController();
                              });
                              customShowDialog(
                                context: context,
                                title: "",
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomTextFieldWidget(
                                      title: "Your Comment",
                                      controller: commentController,
                                      width: double.infinity,
                                    ),
                                  ],
                                ),
                                actionList: [
                                  CustomFilledButtonWidget(
                                    title: "Send",
                                    widthButton: 80,
                                    heightButton: 40,
                                    backgroundButton: darkBlueColor,
                                    textButtonColor: whiteColor,
                                    textButtonSize: 14,
                                    textButtonFontWeight: FontWeight.w500,
                                    onPressed: () async {
                                      await commentProvider
                                          .createProductCommment(
                                        idProduct: dataProduct['id'].toString(),
                                        comment: commentController.text,
                                        datetime: DateTime.now().toString(),
                                      )
                                          .then((_) {
                                        setState(() {
                                          commentController =
                                              TextEditingController();
                                        });
                                        context.pop();
                                      });
                                    },
                                  ),
                                  CustomFilledButtonWidget(
                                    title: "Close",
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
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: FutureBuilder(
                        future: commentProvider.getProductCommment(
                          context: context,
                          idProduct: dataProduct['id'].toString(),
                        ),
                        builder: (context, snapshot) {
                          return snapshot.data!.dataComments.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: snapshot
                                        .data!.dataComments.reversed
                                        .map((data) {
                                      return CustomCommentItemWidget(
                                          currentIdUser: authData != null
                                              ? authData!['data']['id']
                                              : 0,
                                          idUser: data['tbl_user']['id'],
                                          username: data['tbl_user']
                                              ['username'],
                                          commentText: data['comment_text'],
                                          createdAt: data['createdAt']
                                              .toString()
                                              .substring(0, 10),
                                          editComment: () {
                                            setState(() {
                                              commentController =
                                                  TextEditingController(
                                                text: data['comment_text'],
                                              );
                                            });
                                            customShowDialog(
                                              context: context,
                                              title: "",
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CustomTextFieldWidget(
                                                    title: "Your Comment",
                                                    controller:
                                                        commentController,
                                                    width: double.infinity,
                                                  ),
                                                ],
                                              ),
                                              actionList: [
                                                CustomFilledButtonWidget(
                                                  title: "Edit",
                                                  widthButton: 80,
                                                  heightButton: 40,
                                                  backgroundButton:
                                                      darkBlueColor,
                                                  textButtonColor: whiteColor,
                                                  textButtonSize: 14,
                                                  textButtonFontWeight:
                                                      FontWeight.w500,
                                                  onPressed: () async {
                                                    await commentProvider
                                                        .editProductCommment(
                                                      idComment:
                                                          data['id'].toString(),
                                                      idProduct:
                                                          dataProduct['id']
                                                              .toString(),
                                                      comment: commentController
                                                          .text,
                                                      datetime: DateTime.now()
                                                          .toString(),
                                                    )
                                                        .then((_) {
                                                      setState(() {
                                                        commentController =
                                                            TextEditingController();
                                                      });
                                                      context.pop();
                                                    });
                                                  },
                                                ),
                                                CustomFilledButtonWidget(
                                                  title: "Delete",
                                                  widthButton: 80,
                                                  heightButton: 40,
                                                  backgroundButton: Colors.red,
                                                  textButtonColor: whiteColor,
                                                  textButtonSize: 14,
                                                  textButtonFontWeight:
                                                      FontWeight.w500,
                                                  onPressed: () async {
                                                    await commentProvider
                                                        .deleteProductCommment(
                                                      context: context,
                                                      idComment:
                                                          data['id'].toString(),
                                                    )
                                                        .then((_) {
                                                      setState(() {});
                                                      context.pop();
                                                    });
                                                  },
                                                ),
                                                CustomFilledButtonWidget(
                                                  title: "Close",
                                                  widthButton: 80,
                                                  heightButton: 40,
                                                  backgroundButton: yellowColor,
                                                  textButtonColor:
                                                      darkBlueColor,
                                                  textButtonSize: 14,
                                                  textButtonFontWeight:
                                                      FontWeight.w500,
                                                  onPressed: () async {
                                                    context.pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }).toList(),
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: darkBlueColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Belum Ada Komentar!",
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
