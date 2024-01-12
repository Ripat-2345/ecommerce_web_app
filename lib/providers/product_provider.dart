// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:ecommerce_web_app/models/product_model.dart';
import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ProductProvider with ChangeNotifier {
  Future<ProductModel?> getProducts({BuildContext? context}) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/products"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
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

  Future<ProductDetailModel?> getDetailProduct({String? id}) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/products/detail/$id"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      });

      print("status: ${response.statusCode}");
      print("body: ${response.body}");

      if (response.statusCode == 200) {
        return ProductDetailModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ProductModel?> getProductsByIdUser({
    BuildContext? context,
    String? idUser,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];
      final response =
          await http.get(Uri.parse("$baseUrl/products/$idUser"), headers: {
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

  Future addProduct({
    BuildContext? context,
    String? idUser,
    String? productName,
    String? description,
    String? price,
    XFile? picture,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/products"),
      );
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });
      request.fields['name'] = productName!;
      request.fields['description'] = description!;
      request.fields['price'] = price!;
      request.files.add(
        http.MultipartFile.fromBytes(
          'picture',
          await picture!.readAsBytes(),
          filename: picture.name,
          contentType: MediaType('image', 'png'),
        ),
      );
      request.fields['id_user'] = idUser!;
      request.fields['datetime'] = DateTime.now().toString();

      final response = await request.send();

      print("status: ${response.statusCode}");

      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          ProductModel.fromJson(jsonDecode(value));
        });
      } else if (response.statusCode == 401) {
        response.stream.transform(utf8.decoder).listen((value) async {
          await removeFromStorage('authData');
          context!.goNamed('login');
          snackBarInfo(context, jsonDecode(value)['message']);
        });
      }
    } catch (e) {
      print("Error nih: $e");
    }
  }

  Future editProduct({
    BuildContext? context,
    String? idProduct,
    String? idUser,
    String? productName,
    String? description,
    String? price,
    XFile? picture,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];
      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse("$baseUrl/products/$idProduct"),
      );
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });
      request.fields['name'] = productName!;
      request.fields['description'] = description!;
      request.fields['price'] = price!;
      if (picture!.path != '') {
        request.files.add(
          http.MultipartFile.fromBytes(
            'picture',
            await picture.readAsBytes(),
            filename: picture.name,
            contentType: MediaType('image', 'png'),
          ),
        );
      }
      request.fields['id_user'] = idUser!;
      request.fields['datetime'] = DateTime.now().toString();

      final response = await request.send();

      print("status: ${response.statusCode}");

      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          ProductModel.fromJson(jsonDecode(value));
        });
      } else if (response.statusCode == 401) {
        response.stream.transform(utf8.decoder).listen((value) async {
          await removeFromStorage('authData');
          context!.goNamed('login');
          snackBarInfo(context, jsonDecode(value)['message']);
        });
      }
    } catch (e) {
      print("Error nih: $e");
    }
  }

  Future deleteProduct({
    BuildContext? context,
    String? idProduct,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];
      final response = await http
          .delete(Uri.parse("$baseUrl/products/$idProduct"), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

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
