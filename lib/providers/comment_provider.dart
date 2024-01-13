// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:ecommerce_web_app/models/comment_model.dart';
import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class CommentProvider with ChangeNotifier {
  Future<CommentModel?> getProductCommment({
    BuildContext? context,
    String? idProduct,
  }) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/comments/$idProduct"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      print("status: ${response.statusCode}");
      print("body: ${response.body}");

      if (response.statusCode == 200) {
        return CommentModel.fromJson(jsonDecode(response.body));
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

  Future<CommentModel?> createProductCommment({
    BuildContext? context,
    String? idProduct,
    String? datetime,
    String? comment,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];

      final response = await http.post(
        Uri.parse("$baseUrl/comments"),
        body: jsonEncode({
          "comment_text": comment,
          "datetime": datetime,
          "id_product": idProduct,
          "id_user": jsonDecode(dataUser)['data']['id'].toString(),
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
    return null;
  }

  Future<CommentModel?> editProductCommment({
    BuildContext? context,
    String? idComment,
    String? idProduct,
    String? datetime,
    String? comment,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];

      final response = await http.patch(
        Uri.parse("$baseUrl/comments/$idComment"),
        body: jsonEncode({
          "comment_text": comment,
          "datetime": datetime,
          "id_product": idProduct,
          "id_user": jsonDecode(dataUser)['data']['id'].toString(),
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
    return null;
  }

  Future deleteProductCommment({
    BuildContext? context,
    String? idComment,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];

      final response = await http.delete(
        Uri.parse("$baseUrl/comments/$idComment"),
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
