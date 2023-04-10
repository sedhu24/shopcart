import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/providers/user_provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart-screen';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(title: Text(users.name)),
      body: SingleChildScrollView(
        child: Column(children: [Text(users.email)]),
      ),
    );
  }
}
