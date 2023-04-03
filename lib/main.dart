import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopcart/common/bottom_bar.dart';
import 'package:shopcart/constants/global_variables.dart';
import 'package:shopcart/features/auth/screens/auth_screen.dart';
import 'package:shopcart/features/auth/services/authservices.dart';

import 'package:shopcart/providers/user_provider.dart';
import 'package:shopcart/router.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ShopCart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
              const ColorScheme.light(primary: GlobalVariables.secondaryColor),
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
        ),
        onGenerateRoute: ((settings) => generateRoute(settings)),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? const BottomBar()
            : const Authscreen());
  }
}
