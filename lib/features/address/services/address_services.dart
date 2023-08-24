import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopcart/constants/error_handling.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/models/products.dart';
import 'package:shopcart/models/user.dart';
import 'package:shopcart/providers/user_provider.dart';

class AddressServices {
// upload products

  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/save-user-address"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: jsonEncode({
          "address": address,
        }),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          User user = userprovider.user.copyWith(
            address: jsonDecode(response.body)["address"],
          );

          userprovider.setUserFromProvider(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      debugPrint("admin services =>");
      debugPrint(e.toString());
    }
  }

// Place Order

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalsum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalsum,
          },
        ),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Your order has been placed");
          User user = userProvider.user.copyWith(cart: []);
          userProvider.setUserFromProvider(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // void delectproduct({
  //   required BuildContext context,
  //   required Products product,
  //   required VoidCallback onSuccess,
  // }) async {
  //   final userprovider = Provider.of<UserProvider>(context, listen: false);
  //   try {
  //     http.Response response =
  //         await http.post(Uri.parse("$uri/admin/deleteproducts"),
  //             headers: {
  //               'Content-Type': 'application/json; charset=UTF-8',
  //               'x-auth-token': userprovider.user.token,
  //             },
  //             body: jsonEncode({"id": product.id}));

  //     httpErrorHandle(
  //       response: response,
  //       context: context,
  //       onSuccess: () {
  //         onSuccess();
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }
}
