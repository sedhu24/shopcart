import 'package:flutter/material.dart';

String uri = 'http://192.168.225.70:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(17, 82, 253, 1),
      Color.fromRGBO(96, 141, 255, 1),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColorshopping = Color.fromRGBO(17, 82, 253, 1);
  static const secondaryTextColor = Color.fromARGB(255, 62, 73, 88);
  static const textfieldcolors = Color.fromARGB(225, 213, 221, 224);

  static const secondaryColor = Color.fromRGBO(17, 82, 253, 1);
  static const orangeColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const selectedNavBarColor = Color.fromRGBO(17, 82, 253, 1);
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.png',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.png',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.png',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.png',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.png',
    },
  ];
}
