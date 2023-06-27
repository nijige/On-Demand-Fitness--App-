import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_diet_app/data/workout_data.dart';
import 'package:training_diet_app/screens/login_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
