import 'package:flutter/material.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/features/admin/views/order_screen.dart';
import 'package:shopcart/features/admin/views/post_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int page = 0;
  double bottombarwith = 42;
  double bottombarborderwith = 5;

  List<Widget> screens = [
    const PostScreen(),
    const Center(
      child: Text(
        'Analytics  Page',
      ),
    ),
    const OrderScreen()
  ];

  void updatePage(int selectedpage) {
    setState(() {
      page = selectedpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/nschoollogo.png',
                width: 120,
                height: 45,
                // color: Colors.black,
              ),
            ),
            const Text(
              'Admin',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
          ]),
        ),
      ),
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
              child: const Icon(Icons.analytics_outlined),
            ),
          ),

          // orders
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
              child: const Icon(Icons.all_inbox_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
