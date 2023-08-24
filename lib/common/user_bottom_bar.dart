import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopcart/features/account/screens/account_screen.dart';
import 'package:shopcart/features/cart/screens/cart_screen.dart';
import 'package:shopcart/providers/user_provider.dart';
import '../features/home/screens/home_screen.dart';

class UserBottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';

  const UserBottomBar({super.key});

  @override
  State<UserBottomBar> createState() => _UserBottomBarState();
}

class _UserBottomBarState extends State<UserBottomBar> {
  int page = 0;
  double bottombarwith = 42;
  double bottombarborderwith = 5;

  List<Widget> screens = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int selectedpage) {
    setState(() {
      page = selectedpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // short syntax for provider of context
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: screens[page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // Home
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottombarwith,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: bottombarborderwith,
                      color: page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
          ),

          // Account
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottombarwith,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: bottombarborderwith,
                      color: page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
          ),
          // Cart
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottombarwith,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: bottombarborderwith,
                      color: page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor),
                ),
              ),
              child: badges.Badge(
                badgeContent: Text(userCartLen.toString()),
                badgeStyle: const badges.BadgeStyle(
                    elevation: 0, badgeColor: Colors.white),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
