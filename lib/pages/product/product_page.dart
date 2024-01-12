// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_web_app/providers/product_provider.dart';
import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_filled_button_widget.dart';
import 'package:ecommerce_web_app/widgets/custom_icon_button_widget.dart';
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
  List? detailProduct;

  @override
  void initState() {
    super.initState();
    detailProduct = widget.product.split("+");
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    return Title(
      title: detailProduct![0],
      color: whiteColor,
      child: Scaffold(
        backgroundColor: darkBlueColor,
        body: FutureBuilder(
          future: productProvider.getDetailProduct(id: detailProduct![1]),
          builder: (context, snapshot) {
            var data = snapshot.data!.dataProduct;
            return Center(
              child: Container(
                width: 1200,
                height: 800,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InteractiveViewer(
                            child: Image.network(
                              '$baseUrl/images/${data['picture'].split("\\")[1]}',
                              width: 500,
                              height: 500,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['name'],
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
                                data['description'],
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
                              "Rp.${data['price']}",
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
                                      onTap: () {},
                                      iconButton: Icons.remove_rounded,
                                      iconSize: 24,
                                      iconColor: darkBlueColor,
                                      width: 50,
                                      height: 50,
                                      color: yellowColor,
                                    ),
                                    const SizedBox(width: 20),
                                    const Text(
                                      "1",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    CustomIconButtonWidget(
                                      onTap: () {},
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
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
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
