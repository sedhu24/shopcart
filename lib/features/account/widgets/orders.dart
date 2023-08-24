import 'package:flutter/material.dart';
import 'package:shopcart/common/loader.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/features/account/services/account_services.dart';
import 'package:shopcart/features/account/widgets/single_product.dart';
import 'package:shopcart/features/order_details/screens/order_details_screen.dart';
import 'package:shopcart/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // temp list

  List<Order>? orders;

  final AccountServices accountServices = AccountServices();

  void fetchOrders() async {
    orders = await accountServices.fetchmyOrders(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Your Orders",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: const Text(
                      "See all",
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              // display orders
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 0,
                  top: 20,
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetailsScreen.routeName,
                            arguments: orders![index],
                          );
                        },
                        child: SingleProduct(
                          image: orders![index].products[0].imageUrls[0],
                        ),
                      );
                    }),
                // color: Colors.amber,
              )
            ],
          );
  }
}
