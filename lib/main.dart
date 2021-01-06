import 'package:flutter/material.dart';
import 'package:pharma/screens/map_screen.dart';

import 'package:pharma/screens/pharm_details_screen.dart';
import 'package:pharma/screens/pharm_screen.dart';
import 'package:pharma/screens/splash_screen.dart';

import 'package:pharma/screens/villes_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharma',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),

        // fontFamily: 'RobotoCondensed',
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => SplashScreen(),
        VilleScreen.routeName: (ctx) => VilleScreen(),
        PharmScreen.routeName: (ctx) => PharmScreen(),
        PharmDetailsScreen.routeName: (ctx) => PharmDetailsScreen(),
        MapScreen.nameRoute: (ctx) => MapScreen()
      },
    );
  }
}


