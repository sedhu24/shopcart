import 'package:flutter/material.dart';
import 'package:shopcart/common/user_bottom_bar.dart';
import 'package:shopcart/features/address/screen/address_screen.dart';
import 'package:shopcart/features/admin/views/add_products_screen.dart';
import 'package:shopcart/features/auth/screens/auth_screen.dart';
import 'package:shopcart/features/cart/screens/cart_screen.dart';
import 'package:shopcart/features/home/screens/catergory_deals_screen.dart';
import 'package:shopcart/features/home/screens/home_screen.dart';
import 'package:shopcart/features/product_details/screens/product_details_screen.dart';
import 'package:shopcart/features/search/screen/search_screen.dart';
import 'package:shopcart/models/products.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // AuthScreen

    case Authscreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Authscreen(),
      );

    // HomeScreen

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    // CartScreen

    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );

    //  UserBottomBar

    case UserBottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const UserBottomBar(),
      );

    // AddProductScreen

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    // CategoryDealscreen

    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(
          category: category,
        ),
      );

    // SearchScreen

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );

    // ProductDetailsScreen

    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Products;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(
          product: product,
        ),
      );

    // AddressScreen

    case AddressScreen.routeName:
      var totalamount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalamount,
        ),
      );

    // Screen Not Exist
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("screen does not Exist"),
                ),
              ));
  }
}
