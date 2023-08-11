import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/features/cart/services/cart_services.dart';
import 'package:shopcart/features/product_details/services/product_details_services.dart';
import 'package:shopcart/models/products.dart';
import 'package:shopcart/providers/user_provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  final CartServices cartServices = CartServices();

  void increaseQuantity(Products product) {
    productDetailsServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Products product) {
    cartServices.removeFromcart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Products.fromMap(productCart["product"]);
    final quantity = productCart["quantity"];
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(
                    product.imageUrls[0],
                    fit: BoxFit.fitHeight,
                    height: 135,
                    width: 135,
                  ),
                  Container(
                    width: 1,
                    height: 135,
                    color: Colors.black12,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 200,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          product.productName,
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 5,
                        ),
                        child: Text(
                          "\u{20B9}${product.price}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 5,
                        ),
                        child: const Text("Eligible for Free Shipping"),
                      ),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 5,
                        ),
                        child: const Text(
                          "In Stock",
                          style: TextStyle(color: Colors.teal),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black12),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => decreaseQuantity(product),
                              child: Container(
                                width: 35,
                                height: 32,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                              ),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black12, width: 1.5),
                                  color: Colors.white),
                              child: Container(
                                  width: 35,
                                  height: 32,
                                  alignment: Alignment.center,
                                  child: Text(quantity.toString())),
                            ),
                            InkWell(
                              onTap: () => increaseQuantity(product),
                              child: Container(
                                width: 35,
                                height: 32,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
