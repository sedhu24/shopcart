import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/providers/user_provider.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealScreen({super.key, required this.category});

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "Keep Shopping For ${widget.category}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 15),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return const Text("Products");
                }),
          )
        ],
      ),
    );
  }
}
