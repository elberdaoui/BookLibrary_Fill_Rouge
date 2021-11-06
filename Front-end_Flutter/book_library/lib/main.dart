// @dart=2.9

import 'dart:io';
import 'dart:ui';

import 'package:book_library/firebase_init.dart';
import 'package:book_library/models/Cart.dart';
import 'package:book_library/sqlite_database.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:book_library/constants.dart';
import 'package:book_library/routes.dart';
import 'package:book_library/screens/profile/profile_screen.dart';
import 'package:book_library/screens/splash/splash_screen.dart';
import 'package:book_library/theme.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final database = openDatabase(
  //   join(await getDatabasesPath(), 'cart.db'),
  //   onCreate: (db, version) {
  //     return db.execute(
  //       'CREATE TABLE carts(id INTEGER PRIMARY KEY, bookName TEXT, numOfitems INTEGER, photo TEXT, price REAL)',
  //     );
  //   },
  //   version: 1,
  // );
  SqliteDB().openDB();
  // await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [Provider<Cart>(create: (_) => Cart())],
    child: MyApp(),
  ));
  HttpOverrides.global = new MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      //home: SplashScreen(),
      initialRoute: SplashScreen.routeName,
      // initialRoute: ProfileScreen.routeName,
      routes: routes,
    );
  }
}
