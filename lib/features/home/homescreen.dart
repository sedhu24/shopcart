import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // user is get from user provider class
    final user = Provider.of<UserProvider>(context).user;

    // print(json.decode(user.name));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID: ${user.id}"),
            Text("Name: ${user.name}"),
            Text("Email: ${user.email}"),
          ],
        ),
      ),
    );
  }
}
