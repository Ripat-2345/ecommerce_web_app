// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:ecommerce_web_app/models/cart_model.dart';
import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  Future<CartModel?> getCartsByIdUser({
    BuildContext? context,
    String? idUser,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];
      final response =
          await http.get(Uri.parse("$baseUrl/carts/$idUser"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      print("status: ${response.statusCode}");
      print("body: ${response.body}");

      if (response.statusCode == 200) {
        return CartModel.fromJson(jsonDecode(response.body));
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

  Future addProductToCart({
    BuildContext? context,
    String? idProduct,
    String? idUser,
    String? quantity,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];
      final response = await http.post(
        Uri.parse("$baseUrl/carts"),
        body: jsonEncode({
          "id_product": int.parse(idProduct!),
          "id_user": int.parse(idUser!),
          "quantity": int.parse(quantity!),
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("status: ${response.statusCode}");
      print("body: ${response.body}");

      if (response.statusCode == 401) {
        await removeFromStorage('authData');
        context!.goNamed('login');
        snackBarInfo(context, jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future addQtyProductCart({
    BuildContext? context,
    String? idCart,
    String? quantity,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];
      final response = await http.patch(
        Uri.parse("$baseUrl/carts/add/$idCart"),
        body: jsonEncode({
          "quantity": int.parse(quantity!),
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("status: ${response.statusCode}");
      print("body: ${response.body}");
      if (response.statusCode == 401) {
        await removeFromStorage('authData');
        context!.goNamed('login');
        snackBarInfo(context, jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print(e);
    }
  }

  Future removeQtyProductCart({
    BuildContext? context,
    String? idCart,
    String? quantity,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];
      final response = await http.patch(
        Uri.parse("$baseUrl/carts/remove/$idCart"),
        body: jsonEncode({
          "quantity": int.parse(quantity!),
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print("status: ${response.statusCode}");
      print("body: ${response.body}");

      if (response.statusCode == 401) {
        await removeFromStorage('authData');
        context!.goNamed('login');
        snackBarInfo(context, jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print(e);
    }
  }
}
