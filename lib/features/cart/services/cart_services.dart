import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/constants/error_handling.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/models/products.dart';
import 'package:shopcart/models/user.dart';
import 'package:shopcart/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class CartServices {
  //
  //

  // add to cart api services
  void removeFromcart({
    required BuildContext context,
    required Products product,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.delete(
        Uri.parse("$uri/api/remove-from-cart/${product.id}"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          User user = userprovider.user
              .copyWith(cart: jsonDecode(response.body)["cart"]);

          userprovider.setUserFromProvider(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
