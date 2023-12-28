import 'package:flutter/material.dart';

const mobileScreenSize = 360;
const tabletScreenSize = 768;
const laptopScreenSize = 1024;
const desktopScreenSize = 1920;

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
