import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopcart/constants/error_handling.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/models/products.dart';
import 'package:shopcart/providers/user_provider.dart';

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
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("dfrxv4ssv", "bjw6b69b");
      late List<String> imagesurl = [];

      for (int i = 0; i < imagesurl.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: productname,
          ),
        );
        print(res.secureUrl);
        imagesurl.add(res.secureUrl);
      }

      Products product = Products(
        productName: productname,
        description: description,
        category: category,
        quantity: quantity,
        price: price,
        images: imagesurl,
      );

      http.Response response =
          await http.post(Uri.parse("$uri/admin/addproducts"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userprovider.user.token,
              },
              body: product.toJson()
              // body: {
              //   product.toJson(),
              // },
              );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product added Sucessfully");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      print("admin services =>");
    }
  }
}
