import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wall_dock/style/color.dart';

Timer t;

showBottomDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Loading',
            style: TextStyle(color: colorTransparent),
          ),
          backgroundColor: colorTransparent,
          shape: CircleBorder(side: BorderSide(color: colorGray, width: 2)),
        );
      });
}
