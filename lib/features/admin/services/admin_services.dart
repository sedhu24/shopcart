import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shopcart/constants/error_handling.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/models/order.dart';
import 'package:shopcart/models/products.dart';
import 'package:shopcart/providers/user_provider.dart';

class AdminServices {
// upload products

  void sellproducts({
    required BuildContext context,
    required String productname,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("dfrxv4ssv", "eqzmzzvs");
      late List<String> imagesurl = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
          ),
        );

        imagesurl.add(res.secureUrl);
      }

      Products product = Products(
        productName: productname,
        description: description,
        category: category,
        quantity: quantity,
        price: price,
        imageUrls: imagesurl,
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
      debugPrint("admin services =>");
      debugPrint(e.toString());
    }
  }

// getting all the products

  Future<List<Products>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Products> productslist = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/getproducts'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productslist.add(
              Products.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productslist;
  }

  void delectproduct({
    required BuildContext context,
    required Products product,
    required VoidCallback onSuccess,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
          await http.post(Uri.parse("$uri/admin/deleteproducts"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userprovider.user.token,
              },
              body: jsonEncode({"id": product.id}));

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderslist = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderslist.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return orderslist;
  }

  void changeOrderSttus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      debugPrint("admin services => order => change status = 179");
      http.Response response =
          await http.post(Uri.parse("$uri/admin/change-order-status"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userprovider.user.token,
              },
              body: jsonEncode({
                "id": order.id,
                "status": status,
              }));

      debugPrint("admin services => order => change status => 191");

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () => onSuccess,
      );
      // httpErrorHandle(
      //   response: response,
      //   context: context,
      //   onSuccess: () {
      //     onSuccess();
      //   },
      // );
    } catch (e) {
      debugPrint("admin services => order => change status");
      debugPrint(e.toString());
      showSnackBar(context, e.toString());
    }
  }
}
