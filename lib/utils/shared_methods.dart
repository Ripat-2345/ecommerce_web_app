import 'package:ecommerce_web_app/utils/screen_size.dart';
import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void snackBarInfo(
  BuildContext context,
  String msg, {
  Color backgroundColor = Colors.red,
}) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 500),
    backgroundColor: backgroundColor,
    content: Text(msg),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<XFile?> takeImageFromDevice() async {
  final picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
  return file;
}

void customShowDialog({
  BuildContext? context,
  required String title,
  required Widget content,
  List<Widget>? actionList,
}) {
  showDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: darkBlueColor,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: SizedBox(
          width: screenWidth(context) / 2,
          child: content,
        ),
        actions: actionList,
      );
    },
  );
}
