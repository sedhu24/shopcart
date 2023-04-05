import 'package:flutter/material.dart';
import 'package:shopcart/common/bottom_bar.dart';
import 'package:shopcart/features/auth/screens/auth_screen.dart';
import 'package:shopcart/features/home/homescreen.dart';

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

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
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
