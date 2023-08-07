import 'package:flutter/material.dart';
import 'package:shopcart/common/loader.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/features/home/services/home_services.dart';
import 'package:shopcart/features/product_details/screens/product_details_screen.dart';
import 'package:shopcart/models/products.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  Products? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() async {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.productName.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 15,
                      ),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.network(
                      product!.imageUrls[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text("\u{20B9}${product!.price}",
                          style: const TextStyle(
                            fontSize: 18,
                          )),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 5,
                        right: 40,
                      ),
                      child: Text(
                        product!.productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.imageUrls
                              .map(
                                (e) => Image.network(
                                  e,
                                  fit: BoxFit.fitHeight,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                              .toList()),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 15).copyWith(
                        left: 15,
                      ),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'See all deals',
                        style: TextStyle(
                            color: GlobalVariables.secondaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              );
  }
}
