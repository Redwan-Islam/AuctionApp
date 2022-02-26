import 'package:auctionapp/provider/productProvider.dart';
import 'package:auctionapp/view/dashScreen.dart';
import 'package:auctionapp/view/signInWithEmail/logIn.dart';
import 'package:auctionapp/view/signInWithEmail/signUp.dart';
import 'package:auctionapp/view/splashScreen.dart';
import 'package:auctionapp/view/viewEditProduct/ProductDash.dart';
import 'package:auctionapp/view/viewEditProduct/productDetails.dart';
import 'package:auctionapp/view/viewEditProduct/viewProductList.dart';
import 'package:auctionapp/view/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: SplashScreen(),
        routes: {
          SigninPage.routeNames: (context) => SigninPage(),
          LoginPage.routeNames: (context) => LoginPage(),
          dashScreen.routeNames: (context) => dashScreen(),
          welcomeScreen.routeNames: (context) => welcomeScreen(),
          ProductDash.routeNames: (context) => ProductDash(),
          ProductListPage.routeNames: (context) => ProductListPage(),
          productDetails.routeNames: (context) => productDetails(),
        },
      ),
    );
  }
}
