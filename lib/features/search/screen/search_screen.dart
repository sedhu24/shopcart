import 'package:flutter/material.dart';
import 'package:shopcart/common/loader.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/features/home/widgets/address_box.dart';
import 'package:shopcart/features/search/services/search_services.dart';
import 'package:shopcart/features/search/widget/searched_products.dart';
import 'package:shopcart/models/products.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Products>? products = [];

  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
    debugPrint("product length =>  init ${products!.length}");
  }

  void fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProducts(
      context: context,
      searchQuery: widget.searchQuery,
    );
    debugPrint("product length => ${products!.length}");
    setState(() {});
  }

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
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 42,
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(7),
                          child: TextFormField(
                            onFieldSubmitted: navigatetosearchScreen,
                            decoration: InputDecoration(
                              hintText: widget.searchQuery,
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
        body: products == null
            ? const Loader()
            : Column(
                children: [
                  const AddressBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  // Text(widget.searchQuery),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, _) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        return products!.isEmpty
                            ? const Loader()
                            : SearchedProduct(
                                product: products![index],
                              );
                      },
                    ),
                  ),
                ],
              ));
  }
}
