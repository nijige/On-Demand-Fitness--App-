import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:training_diet_app/data/workout_data.dart';
import 'package:training_diet_app/screens/login_view.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

void main() async {
  //initalize hive
  await Hive.initFlutter();

  //open a hive box
  await Hive.openBox("workout_database");

  runApp(const MyApp());
}

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
