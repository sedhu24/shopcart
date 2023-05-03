import 'package:flutter/material.dart';
import 'package:shopcart/constants/global_variables.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.cyan,
        color: GlobalVariables.secondaryColor,
      ),
    );
  }
}
