import 'package:flutter/material.dart';
import 'package:shopcart/common/stars.dart';
import 'package:shopcart/features/account/widgets/single_product.dart';
import 'package:shopcart/models/products.dart';

class SearchedProduct extends StatelessWidget {
  final Products product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
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
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Stars(
                      rating: 3.4,
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
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
