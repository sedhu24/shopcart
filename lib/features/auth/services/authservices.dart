import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopcart/common/user_bottom_bar.dart';
import 'package:shopcart/constants/error_handling.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shopcart/providers/user_provider.dart';

import '../../../constants/global_variables.dart';

class AuthService {
// sign  up User
  void signUpUser(
      {required String email,
      required BuildContext context,
      required String password,
      required String name}) async {
    try {
      User user = User(
        id: "",
        email: email,
        name: name,
        password: password,
        address: "",
        type: "",
        token: "",
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account Created Login With Same credentials',
          );
        },
      );
      debugPrint(res.statusCode as String?);
      debugPrint(res.body);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign  In User
  void signInUser({
    required String email,
    required BuildContext context,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // print(res.body);
      // print(res.statusCode);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          Navigator.pushNamedAndRemoveUntil(
            context,
            UserBottomBar.routeName,
            (route) => false,
          );

          // showSnackBar(
          //   context,
          //   'Login successful',
          // );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

// get user Data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString("x-auth-token", " ");
      }

      var tokenres = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenres.body);

      if (response == true) {
        // get user data

        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false)
            .setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
