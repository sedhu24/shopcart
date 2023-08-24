import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/common/custom_buttom.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/features/search/screen/search_screen.dart';
import 'package:shopcart/models/order.dart';
import 'package:intl/intl.dart';
import 'package:shopcart/providers/user_provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details-screen';
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;

  void navigatetosearchScreen(String query) {
    if (query.isEmpty) {
      showSnackBar(context, "Please enter a product name");
    } else {
      Navigator.pushNamed(
        context,
        SearchScreen.routeName,
        arguments: query,
      );
    }
  }

  @override
  void initState() {
    currentStep = widget.order.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // View order details
              const Text(
                "View order details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Date :         ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.order.orderedAt),
                    )}"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Order Id :             ${widget.order.id}"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Order Total :        \u{20B9} ${widget.order.totalPrice}"),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              // Purchase details
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Purchase details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].imageUrls[0],
                            height: 100,
                            width: 100,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.products[i].productName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text("Qty : ${widget.order.quantity[i]}"),
                              ],
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
              // Tracking details
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Tracking",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  controlsBuilder: (context, details) {
                    if (user.type == "admin") {
                      return CustomButton(
                        text: "Done",
                        onTap: () {},
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  steps: [
                    Step(
                      title: const Text("Pending"),
                      content:
                          const Text("Your order is preparing for shipping"),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                        title: const Text("Completed"),
                        content: const Text(
                            "Your order has been delivered, you are yet to recieve"),
                        isActive: currentStep > 1,
                        state: currentStep > 1
                            ? StepState.complete
                            : StepState.disabled),
                    Step(
                        title: const Text("Received"),
                        content: const Text(
                            "Your order has been delivered & recieved"),
                        isActive: currentStep > 2,
                        state: currentStep > 2
                            ? StepState.complete
                            : StepState.disabled),
                    Step(
                        title: const Text("Deliverd"),
                        content: const Text("Your order has been completed"),
                        isActive: currentStep >= 3,
                        state: currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
