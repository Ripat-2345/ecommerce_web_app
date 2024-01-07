import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void snackBarInfo(BuildContext context, String msg) {
  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text(msg),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<XFile?> takeImageFromDevice() async {
  final picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
  return file;
}
