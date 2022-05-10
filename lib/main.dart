import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:snau_survey/views/splash_screen/view.dart';
import 'package:snau_survey/views/views.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const SplashScreenView(),
    );
  }
}
