import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/providers/user_provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: 'Hello,  ',
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                      text: users.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ))
                ]),
          ),
        ],
      ),
    );
  }
}
