// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:convert';

import 'package:ecommerce_web_app/models/auth_model.dart';
import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider with ChangeNotifier {
  // todo: login services
  Future<AuthModel?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/auth/login"),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      print("status: ${response.statusCode}");
      print("body: ${response.body}");

      if (response.statusCode == 200) {
        saveToStorage('authData', response.body);
        context.goNamed('home');
        return AuthModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        snackBarInfo(context, jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  // todo: register services
  Future register({
    required BuildContext context,
    required String name,
    required String username,
    required String email,
    required String password,
    required XFile? avatar,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/auth/register"),
      );
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'multipart/form-data',
      });
      request.fields['name'] = name;
      request.fields['username'] = username;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.files.add(
        http.MultipartFile.fromBytes(
          'avatar',
          await avatar!.readAsBytes(),
          filename: avatar.name,
          contentType: MediaType('image', 'png'),
        ),
      );

      final response = await request.send();

      print("status: ${response.statusCode}");

      if (response.statusCode == 200) {
        context.goNamed('login');
      } else if (response.statusCode == 401) {
        response.stream.transform(utf8.decoder).listen((value) {
          snackBarInfo(context, jsonDecode(value)['message']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future forgotPassword({BuildContext? context, String? email}) async {
    try {
      final response =
          await http.post(Uri.parse("$baseUrl/auth/forgot-password"),
              body: jsonEncode({
                "email": email,
              }),
              headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      print("status: ${response.statusCode}");
      print("body: ${response.body}");

      if (response.statusCode == 200) {
        snackBarInfo(context!, "Check Email Anda $email");
      } else if (response.statusCode == 401) {
        snackBarInfo(context!, "Email Anda Tidak Ditemukan!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future changePassword({
    BuildContext? context,
    String? password,
    String? confirmPassword,
    String? token,
  }) async {
    try {
      Map<String, dynamic>? decodedToken = JwtDecoder.decode(token!);
      final response =
          await http.post(Uri.parse("$baseUrl/auth/change-password"),
              body: jsonEncode({
                "id": decodedToken['idUser'],
                "password": password,
                "confirmPassword": confirmPassword,
              }),
              headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      print("status: ${response.statusCode}");
      print("body: ${response.body}");

      if (response.statusCode == 200) {
        context!.goNamed('login');
      } else if (response.statusCode == 401) {
        snackBarInfo(context!, jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print(e);
    }
  }
}
