import 'package:flutter/material.dart';

import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/common/custom_textfiel.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/features/address/services/address_services.dart';
import 'package:shopcart/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address-screen';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingcontroller = TextEditingController();
  final TextEditingController areacontroller = TextEditingController();
  final TextEditingController pincodecontroller = TextEditingController();
  final TextEditingController citycontroller = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String adddressToBeUsed = '';

  final AddressServices addressServices = AddressServices();

  // final Future<PaymentConfiguration> _googlePayConfigure =
  //     PaymentConfiguration.fromAsset('gpay.json');

  // final Future<PaymentConfiguration> _googlePayConfigurejson =
  //     PaymentConfiguration.fromAsset('gpay.json');
  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Totla Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingcontroller.dispose();
    areacontroller.dispose();
    pincodecontroller.dispose();
    citycontroller.dispose();
  }

  void ongpayresult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: adddressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: adddressToBeUsed,
      totalsum: double.parse(widget.totalAmount),
    );
  }

  void onapplepayresult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: adddressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: adddressToBeUsed,
      totalsum: double.parse(widget.totalAmount),
    );
  }

  // Finalizing  the address to buy   addrestobeused  = address from provider or from form

  void payPressed(String addressFromProvider) {
    adddressToBeUsed = "";

    bool isForm = flatBuildingcontroller.text.isNotEmpty ||
        areacontroller.text.isNotEmpty ||
        pincodecontroller.text.isNotEmpty ||
        citycontroller.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        adddressToBeUsed =
            '${flatBuildingcontroller.text}, ${areacontroller.text}, ${citycontroller.text} - ${pincodecontroller.text}';
        if (Provider.of<UserProvider>(context, listen: false)
            .user
            .address
            .isEmpty) {
          addressServices.saveUserAddress(
              context: context, address: adddressToBeUsed);
        }
        addressServices.placeOrder(
          context: context,
          address: adddressToBeUsed,
          totalsum: double.parse(widget.totalAmount),
        );
      } else {
        throw Exception("Please enter all the values! ");
      }
    } else if (addressFromProvider.isNotEmpty) {
      adddressToBeUsed = addressFromProvider;
      if (Provider.of<UserProvider>(context, listen: false)
          .user
          .address
          .isEmpty) {
        addressServices.saveUserAddress(
            context: context, address: adddressToBeUsed);
      }
      addressServices.placeOrder(
        context: context,
        address: adddressToBeUsed,
        totalsum: double.parse(widget.totalAmount),
      );
    } else {
      showSnackBar(context, 'Error');
      // throw Exception("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: const Text("Select address to proceed"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: flatBuildingcontroller,
                      hint: "Flat, House no, Building",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: areacontroller,
                      hint: "Area, Street",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: citycontroller,
                      hint: "Town/City",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: pincodecontroller,
                      hint: "Pincode",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              InkWell(
                highlightColor: GlobalVariables.orangeColor,
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  payPressed(address);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: double.infinity,
                  height: 50,
                  child: const Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              )

// From Json
              // Container(
              //   margin: const EdgeInsets.symmetric(
              //     horizontal: 10,
              //   ),
              //   width: double.infinity,
              //   height: 50,
              //   decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Colors.white,
              //         width: 0.0,
              //       ),
              //       borderRadius: BorderRadius.circular(50),
              //       color: Colors.white),
              //   child: OutlinedButton(
              //     style: ElevatedButton.styleFrom(
              //       foregroundColor: GlobalVariables.orangeColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(50),
              //       ),
              //     ),
              //     onPressed: () {
              //       payPressed(address);
              //     },
              //     child: const Text(
              //       "Cash on Delivery",
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),

              // GooglePayButton(
              //   width: double.infinity,
              //   height: 50,
              //   paymentConfiguration: PaymentConfiguration.fromJsonString(
              //       payment_configuration.defaultGooglePay),
              //   onPressed: () => payPressed(address),
              //   margin: const EdgeInsets.only(top: 15),
              //   type: GooglePayButtonType.buy,
              //   onPaymentResult: ongpayresult,
              //   paymentItems: paymentItems,
              //   loadingIndicator: const Loader(),
              // ),

              // From Asset

              // FutureBuilder<PaymentConfiguration>(
              //   future: _googlePayConfigure,
              //   builder: (context, snapshot) => snapshot.hasData
              //       ? GooglePayButton(
              //           paymentConfiguration: snapshot.data!,
              //           type: GooglePayButtonType.buy,
              //           width: double.infinity,
              //           height: 50,
              //           onPressed: () => payPressed(address),
              //           onPaymentResult: ongpayresult,
              //           paymentItems: paymentItems,
              //           // loadingIndicator: const Center(child: Loader()),
              //         )
              //       : const SizedBox.shrink(),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
