import 'package:flutter/material.dart';
import 'package:shopcart/common/loader.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/features/account/widgets/single_product.dart';
import 'package:shopcart/features/admin/services/admin_services.dart';
import 'package:shopcart/features/admin/views/add_products_screen.dart';
import 'package:shopcart/models/products.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Products>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void navigateToAddProducts() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void deleteproducts(Products product, int index) {
    adminServices.delectproduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);

          setState(() {
            showSnackBar(
                context, "${product.productName} Successfully deleted");
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 200,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final productdata = products![index];

                  return Container(
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
                          height: 130,
                          child: SingleProduct(
                            image: productdata.imageUrls[0],
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
                                  productdata.productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              IconButton(
                                  onPressed: () =>
                                      deleteproducts(productdata, index),
                                  icon: const Icon(Icons.delete_outline))
                            ],
                          ),
                        )
                      ],
                    )),
                  );
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              tooltip: "Add a Product",
              backgroundColor: GlobalVariables.secondaryColor,
              onPressed: navigateToAddProducts,
              child: const Icon(Icons.add),
            ),
          );
  }
}
