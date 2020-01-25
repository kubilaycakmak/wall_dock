import 'package:flutter/material.dart';
import 'package:wall_dock/style/color.dart';
import 'home.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colorTransparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark));
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
