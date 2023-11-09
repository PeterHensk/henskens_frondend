import 'package:flutter/material.dart';
import 'package:henskens/screens/dinoDetection/dino_screen.dart';
import 'package:henskens/screens/login/login_screen.dart';
import 'package:henskens/screens/portfolio/portfolio_screen.dart';

void main() {
  runApp(const GlobeApp());
}

class GlobeApp extends StatelessWidget {
  const GlobeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      routes: {
        '/': (context) => LoginPage(),
        '/arDino': (context) => ArPage(), // Define the route for your home screen.
        '/portfolio': (context) => PortfolioScreen(), // Define the route for your portfolio screen.
      },
      initialRoute: '/',
    );
  }
}
