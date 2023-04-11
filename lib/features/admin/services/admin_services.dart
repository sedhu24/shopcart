import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

import 'package:shopcart/constants/utils.dart';

class AdminServices {
  void sellproducts({
    required BuildContext context,
    required String productname,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dfrxv4ssv", "bjw6b69b");
      List<File> imagesurl = [];

      for (int i = 0; i < imagesurl.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: productname,
          ),
        );
        imagesurl.add(res.secureUrl as File);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
