// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:ecommerce_web_app/utils/shared_methods.dart';
import 'package:ecommerce_web_app/utils/shared_preferences_services.dart';
import 'package:ecommerce_web_app/utils/shared_values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UserProvider with ChangeNotifier {
  Future updateBioUser({
    BuildContext? context,
    String? idUser,
    String? name,
    String? username,
    String? email,
    XFile? avatar,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];
      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse("$baseUrl/users"),
      );
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });
      request.fields['name'] = name!;
      request.fields['username'] = username!;
      if (jsonDecode(dataUser)['data']['email'] != email) {
        request.fields['email'] = email!;
      }
      if (avatar!.path != '') {
        request.files.add(
          http.MultipartFile.fromBytes(
            'avatar',
            await avatar.readAsBytes(),
            filename: avatar.name,
            contentType: MediaType('image', 'png'),
          ),
        );
      }
      request.fields['id_user'] = idUser!;

      final response = await request.send();

      print("status: ${response.statusCode}");

      if (response.statusCode == 200) {
        await removeFromStorage('authData');
        context!.goNamed('login');
        snackBarInfo(context, "Silahkan Login Ulang");
      } else if (response.statusCode == 400) {
        response.stream.transform(utf8.decoder).listen((value) async {
          snackBarInfo(context!, jsonDecode(value)['message']);
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

  Future updatePasswordUser({
    BuildContext? context,
    String? idUser,
    String? password,
    String? currentPassword,
  }) async {
    try {
      final dataUser = await readFromStorage('authData');
      final token = jsonDecode(dataUser!)['token'];

      final response = await http.patch(Uri.parse("$baseUrl/users"),
          body: jsonEncode({
            "id_user": idUser,
            "current_password": currentPassword,
            "password": password,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      print("status: ${response.statusCode}");
      print("body: ${response.body}");

      if (response.statusCode == 200) {
        await removeFromStorage('authData');
        context!.goNamed('login');
      } else if (response.statusCode == 401) {
        snackBarInfo(context!, jsonDecode(response.body)['message']);
      } else if (response.statusCode == 404) {
        snackBarInfo(context!, jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print(e);
    }
  }
}
