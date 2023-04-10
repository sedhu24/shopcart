import 'dart:io';

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

pickimages() async {
  List<File> images = [];

  try {} catch (e) {
    debugPrint(e.toString());
  }
}
