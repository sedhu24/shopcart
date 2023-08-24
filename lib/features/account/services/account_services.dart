import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/constants/error_handling.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/features/account/widgets/orders.dart';
import 'package:shopcart/models/order.dart';
import 'package:shopcart/models/user.dart';
import 'package:shopcart/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class AccountServices {
  // /api/orders/my

  void fetchmyOrders({
    required BuildContext context,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri//api/orders/my"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            // orderList.add()
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      debugPrint("admin services =>");
      debugPrint(e.toString());
    }
  }
}
