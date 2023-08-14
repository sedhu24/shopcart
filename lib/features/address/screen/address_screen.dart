import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/common/custom_buttom.dart';
import 'package:shopcart/common/custom_textfiel.dart';
import 'package:shopcart/common/loader.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/constants/utils.dart';
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

  // late final Future<PaymentConfiguration> _googlePayConfigure;

  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    // _googlePayConfigure = PaymentConfiguration.fromAsset("gpay.json");
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

  void ongpayresult(res) {}
  void onapplepayresult(res) {}

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
      } else {
        throw Exception("Please enter all the values! ");
      }
    } else if (addressFromProvider.isNotEmpty) {
      adddressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Error');
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
                      controller: pincodecontroller,
                      hint: "Pincode",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: citycontroller,
                      hint: "Town/City",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              GooglePayButton(
                width: double.infinity,
                height: 50,
                onPressed: () => payPressed(address),
                margin: const EdgeInsets.only(top: 15),
                type: GooglePayButtonType.buy,
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: ongpayresult,
                paymentItems: paymentItems,
                loadingIndicator: const Loader(),
              ),
              const SizedBox(
                height: 10,
              ),
              ApplePayButton(
                width: double.infinity,
                height: 50,
                onPressed: () => payPressed(address),
                margin: const EdgeInsets.only(top: 15),
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                paymentConfigurationAsset: 'apple.json',
                onPaymentResult: onapplepayresult,
                paymentItems: paymentItems,
                loadingIndicator: const Loader(),
              ),

              // FutureBuilder<PaymentConfiguration>(
              //     builder: (context, snapshot) => snapshot.hasData
              //         ? GooglePayButton(
              //             paymentConfiguration: snapshot.data!,
              //             type: GooglePayButtonType.buy,
              //             onPaymentResult: ongpayresult,
              //             paymentItems: paymentItems,
              //             loadingIndicator: const Center(child: Loader()),
              //           )
              //         : const SizedBox.shrink(),)
            ],
          ),
        ),
      ),
    );
  }
}
