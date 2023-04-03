import 'package:flutter/material.dart';
import 'package:shopcart/constants/global_variables.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/nschoollogo.png',
                width: 120,
                height: 45,
                // color: Colors.black,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
