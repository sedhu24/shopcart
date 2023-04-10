import 'package:flutter/material.dart';
import 'package:shopcart/common/user_bottom_bar.dart';
import 'package:shopcart/features/admin/views/add_products_screen.dart';
import 'package:shopcart/features/auth/screens/auth_screen.dart';
import 'package:shopcart/features/cart/screens/cart_screen.dart';
import 'package:shopcart/features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Authscreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Authscreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );

    case UserBottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const UserBottomBar(),
      );

    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

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
