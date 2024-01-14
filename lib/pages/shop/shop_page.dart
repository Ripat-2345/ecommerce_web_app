import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  final List? dataProducts;

  const ShopPage({
    super.key,
    this.dataProducts,
  });

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List? products;

  void filterSearchResults(String query) {
    setState(() {
      products = widget.dataProducts!.where((item) {
        return item['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      products = widget.dataProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        const SizedBox(height: 50),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "All Products",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 400,
                    child: TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search here....",
                        filled: true,
                        fillColor: whiteColor,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 24,
                          color: darkBlueColor,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 8,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: blueColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: darkBlueColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              widget.dataProducts == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: products!.reversed.map(
                        (data) {
                          return CustomProductWidget(
                            idProduct: data['id'].toString(),
                            productName: data['name'],
                            price: data['price'].toString(),
                            description: data['description'],
                            productImageUrl: data['picture'],
                            textColor: darkBlueColor,
                          );
                        },
                      ).toList(),
                      // SizedBox(width: 50),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
