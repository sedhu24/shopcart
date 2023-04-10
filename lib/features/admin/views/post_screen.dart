import 'package:flutter/material.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/features/admin/views/add_products_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  void navigateToAddProducts() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Posts Scrren'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a Product",
        backgroundColor: GlobalVariables.secondaryColor,
        onPressed: navigateToAddProducts,
        child: const Icon(Icons.add),
      ),
    );
  }
}
