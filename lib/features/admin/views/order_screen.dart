import 'package:flutter/material.dart';
import 'package:shopcart/common/loader.dart';
import 'package:shopcart/features/account/widgets/single_product.dart';
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
                crossAxisCount: 2),
            itemBuilder: ((context, index) {
              final orderdata = orders![index];
              return SizedBox(
                height: 140,
                child: SingleProduct(
                  image: orderdata.products[0].imageUrls[0],
                ),
              );
            }));
  }
}
