import 'dart:convert';

import 'package:ecommerce_web_app/providers/cart_provider.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            right: 20,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: darkBlueColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'My Shopping Cart',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FutureBuilder(
                    future: cartProvider.getCartsByIdUser(
                      context: context,
                      idUser: authData!['data']['id'].toString(),
                    ),
                    builder: (context, snapshot) {
                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        runAlignment: WrapAlignment.spaceBetween,
                        alignment: WrapAlignment.spaceBetween,
                        children: snapshot.data!.dataCarts.map((data) {
                          return CustomCartItemWidget(
                            name: data['tbl_product']['name'],
                            description: data['tbl_product']['description'],
                            qty: data['quantity'].toString(),
                            price: data['tbl_product']['price'].toString(),
                            imgUrl: data['tbl_product']['picture'],
                            removeQty: () async {
                              await cartProvider.removeQtyProductCart(
                                context: context,
                                idCart: data['id'].toString(),
                                quantity: '1',
                              );
                              setState(() {});
                            },
                            addQty: () async {
                              await cartProvider.addQtyProductCart(
                                context: context,
                                idCart: data['id'].toString(),
                                quantity: '1',
                              );
                              setState(() {});
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
