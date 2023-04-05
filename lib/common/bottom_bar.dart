import 'package:flutter/material.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopcart/features/account/screens/account_screen.dart';
import 'package:shopcart/features/home/homescreen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';

  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int page = 0;
  double bottombarwith = 42;
  double bottombarborderwith = 5;

  List<Widget> screens = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(
      child: Text('Cart Page'),
    )
  ];

  void updatePage(int selectedpage) {
    setState(() {
      page = selectedpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                child: const badges.Badge(
                  badgeContent: Text("2"),
                  badgeStyle:
                      badges.BadgeStyle(elevation: 0, badgeColor: Colors.white),
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
