import 'package:flutter/material.dart';
import 'package:garifuna_movil_app/screens/home_screen.dart';


void main() {
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garifuna App',
      theme: ThemeData(
          primaryColor: Color(0xFF009688),
          primaryColorDark: Color(0xFF00796B),
          accentColor: Color(0xFFFFC107),
          fontFamily: 'Gotham'
          ),
      home: HomeScreen(title: 'Garifuna App'),
    );
  }
}
