// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:ecommerce_web_app/models/product_model.dart';
import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  Future<ProductModel?> getProducts({BuildContext? context}) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];
      final response = await http.get(Uri.parse("$baseUrl/products"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print("status: ${response.statusCode}");
      print("body: ${response.body}");
      if (response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        await removeFromStorage('authData');
        context!.goNamed('login');
        snackBarInfo(context, jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
