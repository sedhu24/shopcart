import 'package:flutter/material.dart';
import 'package:shopcart/common/loader.dart';
import 'package:shopcart/features/account/widgets/single_product.dart';
import 'package:shopcart/features/order_details/screens/order_details_screen.dart';
import 'package:shopcart/models/order.dart';
import 'package:shopcart/features/admin/services/admin_services.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  fetchAllOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2),
            itemBuilder: ((context, index) {
              final orderdata = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetailsScreen.routeName,
                      arguments: orderdata);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            spreadRadius: 1,
                            offset: Offset(4, 4)),
                      ],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black12)),
                  child: (Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(
                          image: orderdata.products[0].imageUrls[0],
                        ),
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                orderdata.products[0].productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
                ),
              );
              // SizedBox(
              //   height: 140,
              //   child: SingleProduct(
              //     image: orderdata.products[0].imageUrls[0],
              //   ),
              // );
            }),
          );
  }
}
