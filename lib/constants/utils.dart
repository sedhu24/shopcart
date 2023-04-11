import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickimages() async {
  List<File> images = [];

  try {
    var file = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (file != null && file.files.isNotEmpty) {
      for (int i = 0; i < file.files.length; i++) {
        images.add(File(file.files[i].path!));
        debugPrint(images.toString());
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images;
}
