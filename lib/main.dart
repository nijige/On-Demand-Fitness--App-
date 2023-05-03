import 'package:flutter/material.dart';
import 'package:training_diet_app/screens/login_view.dart';
import 'package:training_diet_app/screens/welcom_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
