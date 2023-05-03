import 'package:flutter/material.dart';
import 'package:shopcart/models/products.dart';

class SearchedProduct extends StatelessWidget {
  final Products product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.amber,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Image.network(
              product.imageUrls[0],
              fit: BoxFit.fitHeight,
              height: 135,
              width: 135,
            )
          ]),
        )
      ],
    );
  }
}
