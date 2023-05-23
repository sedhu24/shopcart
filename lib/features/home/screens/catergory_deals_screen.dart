import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/common/loader.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/features/home/services/home_services.dart';
import 'package:shopcart/features/product_details/screens/product_details_screen.dart';
import 'package:shopcart/models/products.dart';
import 'package:shopcart/providers/user_provider.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealScreen({super.key, required this.category});

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<Products>? productList;

  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    double mygridSpacing() {
      return screensize.width >= 1200
          ? 30
          : (screensize.width > 600 && screensize.width < 1200)
              ? 20
              : 10;
    }

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
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Keep Shopping For ${widget.category}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: productList == null
                      ? Center(
                          child: Text(
                              "No products available for ${widget.category}"),
                        )
                      : GridView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          itemCount: productList!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: screensize.width >= 1200
                                ? 3
                                : (screensize.width > 600 &&
                                        screensize.width < 1200)
                                    ? 2
                                    : 1,
                            childAspectRatio: 2,
                            mainAxisSpacing: mygridSpacing(),
                            crossAxisSpacing: mygridSpacing(),
                          ),
                          itemBuilder: (context, index) {
                            final product = productList![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  ProductDetailsScreen.routeName,
                                  arguments: product,
                                );
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 135,
                                    width: 135,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black12, width: 0.5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child:
                                            Image.network(product.imageUrls[0]),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                      top: 0,
                                      left: 15,
                                    ),
                                    child: Text(
                                      product.productName,
                                      style: TextStyle(fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                )
              ],
            ),
    );
  }
}
