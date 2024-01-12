// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:ecommerce_web_app/providers/cart_provider.dart';
import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomProductWidget extends StatelessWidget {
  final String? idProduct;
  final String? productName;
  final String? description;
  final String? price;
  final String? productImageUrl;
  final Color backgroundColor;
  final Color textColor;
  const CustomProductWidget({
    super.key,
    this.productName = "Barang Pilihan Anak Bangsa",
    this.description =
        "Mantap kali barangnya dan bisa dibuat makan makan sama keluarga besar sambil baca komik",
    this.price = "100000",
    this.productImageUrl = "url gambar",
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    required this.idProduct,
  });

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Container(
      width: 250,
      height: 350,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                context.goNamed(
                  'product',
                  pathParameters: {
                    "product": "$productName+$idProduct",
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: productImageUrl!.isNotEmpty
                        ? NetworkImage(
                            '$baseUrl/images/${productImageUrl!.split("\\")[1]}',
                          ) as ImageProvider
                        : const AssetImage("assets/images/product1.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sold: 100+",
                    style: TextStyle(
                      color: yellowColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 230,
                    child: Text(
                      productName!,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    width: 230,
                    child: Text(
                      description!,
                      style: TextStyle(
                        color: textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rp.$price",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              CustomIconButtonWidget(
                onTap: () async {
                  final data = await readFromStorage('authData');
                  if (data == null) {
                    snackBarInfo(
                      context,
                      "Anda Harus Login Terlebih Dahulu!",
                    );
                  } else {
                    await cartProvider
                        .addProductToCart(
                      context: context,
                      idProduct: idProduct,
                      idUser: jsonDecode(data)['data']['id'].toString(),
                      quantity: '1',
                    )
                        .then((_) {
                      snackBarInfo(
                        backgroundColor: Colors.green,
                        context,
                        "Berhasil Menambahkan!",
                      );
                    });
                  }
                },
                iconButton: Icons.add_shopping_cart_rounded,
                iconSize: 20,
                iconColor: Colors.black,
                width: 45,
                height: 45,
                color: yellowColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
