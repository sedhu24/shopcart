import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopcart/common/custom_buttom.dart';
import 'package:shopcart/common/stars.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/common/custom_buttom.dart';
import 'package:shopcart/features/search/screen/search_screen.dart';
import 'package:shopcart/models/products.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details-screen';
  final Products product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  void navigatetosearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(7),
                    child: TextFormField(
                      onFieldSubmitted: navigatetosearchScreen,
                      decoration: InputDecoration(
                        hintText: "Search ShopCart",
                        hintStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              size: 23,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                          top: 10,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
            Container(
              color: Colors.transparent,
              height: 42,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(
                Icons.mic,
                size: 25,
                color: Colors.black,
              ),
            )
          ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              alignment: Alignment.topRight,
              child: const Stars(rating: 4.5),
            ),

            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(widget.product.id!),
            //     const Stars(rating: 3.5),
            //   ],
            // ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              widget.product.productName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          CarouselSlider(
            items: widget.product.imageUrls.map((i) {
              return Builder(builder: (BuildContext context) {
                return Image.network(
                  i,
                  fit: BoxFit.cover,
                  height: 200,
                );
              });
            }).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              height: 300,
              enlargeCenterPage: true,
            ),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text: 'Deal Price : ',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: "\u{20B9}${widget.product.price}",
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product.description),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: CustomButton(
              text: 'Buy Now',
              backgroundcolor: GlobalVariables.orangeColor,
              onTap: () {},
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: CustomButton(
              text: 'Add to Cart',
              textColor: Colors.black,
              backgroundcolor: const Color.fromRGBO(254, 216, 19, 1),
              onTap: () {},
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "Rate the Product",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RatingBar.builder(
                glow: false,
                // glowColor: GlobalVariables.orangeColor,
                initialRating: 0,
                minRating: 1,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemBuilder: (context, _) {
                  return const Icon(
                    Icons.star,
                    color: GlobalVariables.orangeColor,
                  );
                },
                onRatingUpdate: (rating) {}),
          )
        ]),
      ),
    );
  }
}
