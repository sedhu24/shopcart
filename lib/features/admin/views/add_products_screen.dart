import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopcart/constants/utils.dart';
import 'package:shopcart/common/custom_buttom.dart';
import 'package:shopcart/common/custom_textfiel.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/features/admin/services/admin_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productsNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminServices adminServices = AdminServices();

  @override
  void dispose() {
    super.dispose();

    productsNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  String categories = 'Mobiles';

  List<File> images = [];

  final addProductsFormKey = GlobalKey<FormState>();

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

  void sellProducts() {
    if (addProductsFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellproducts(
        context: context,
        productname: productsNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: int.parse(quantityController.text),
        category: categories,
        images: images,
      );
    }
  }

  void selectimages() async {
    var result = await pickimages();

    debugPrint(result.toString());

    setState(() {
      images = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Add  Products',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Form(
            key: addProductsFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? GestureDetector(
                        onTap: selectimages,
                        child: CarouselSlider(
                          items: images.map((i) {
                            return Builder(builder: (BuildContext context) {
                              return Image.file(
                                i,
                                fit: BoxFit.contain,
                                height: 200,
                                width: 200,
                              );
                            });
                          }).toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            pauseAutoPlayInFiniteScroll: true,
                            viewportFraction: 1,
                            height: 200,
                            enlargeCenterPage: true,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: selectimages,
                        child: DottedBorder(
                          color: GlobalVariables.secondaryColor,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.folder_open_outlined,
                                    size: 40),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  hint: "Product Name",
                  controller: productsNameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  hint: "Description",
                  maxLines: 7,
                  controller: descriptionController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  hint: "Price",
                  controller: priceController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  hint: "Quantity",
                  inputType: TextInputType.number,
                  controller: quantityController,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    alignment: Alignment.topRight,
                    value: categories,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newvalue) {
                      setState(() {
                        categories = newvalue!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(text: 'Sell', onTap: sellProducts),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
