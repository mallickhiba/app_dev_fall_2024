import 'package:flutter/material.dart';
import 'package:iba_course_2/calculator_provider.dart';
import 'package:iba_course_2/my_calculator.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorProvider(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const MyCalculator(),
      ),
    );
      }
  }
  // debugShowCheckedModeBanner: false,
          // themeMode: provider.themeState,
          // theme: ThemeData(brightness: Brightness.light),
          // darkTheme: ThemeData(
          //   iconTheme: IconThemeData(color:Colors.red),
          //   brightness: Brightness.dark,
          // ),
