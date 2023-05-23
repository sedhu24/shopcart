import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/constants/error_handling.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/models/products.dart';
import 'package:shopcart/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Products product,
    required double rating,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/rate-product"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
