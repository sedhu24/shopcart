import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/common/custom_buttom.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/features/address/screen/address_screen.dart';
import 'package:shopcart/features/cart/widgets/cart_product.dart';
import 'package:shopcart/features/cart/widgets/cart_subtotal.dart';
import 'package:shopcart/features/home/widgets/address_box.dart';
import 'package:shopcart/features/search/screen/search_screen.dart';
import 'package:shopcart/providers/user_provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart-screen';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigatetosearchScreen(String query) {
    if (query.isEmpty) {
    } else {
      Navigator.pushNamed(
        context,
        SearchScreen.routeName,
        arguments: query,
      );
    }
  }

  void navigatetoaddressScreen(int sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    int sum = 0;
    user.cart
        .map((e) => sum += e["quantity"] * e["product"]["price"] as int)
        .toList();
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
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
                      ],
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
        child: Column(children: [
          const AddressBox(),
          const CartSubtotal(),
          user.cart.isEmpty
              ? Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black12,
                        size: 40,
                      ),
                      Text(
                        "No items in cart",
                        style: TextStyle(fontSize: 20, color: Colors.black12),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: CustomButton(
                        textColor: Colors.black,
                        text: 'Proceed to Buy (${user.cart.length} items)',
                        backgroundcolor: GlobalVariables.orangeColor,
                        fontWeight: FontWeight.bold,
                        onTap: () => navigatetoaddressScreen(sum),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.08),
                      height: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: user.cart.length,
                        itemBuilder: (context, index) {
                          return CartProduct(index: index);
                        })
                  ],
                ),
        ]),
      ),
    );
  }
}
