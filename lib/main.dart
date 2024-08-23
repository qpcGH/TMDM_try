import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(),
      home: FlutterSplashScreen.fadeIn(
        backgroundColor: Colors.grey,

        childWidget: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("assets/logo.png",),
        ),

        nextScreen:  HomeScreen(),
      ),
    );
  }
}

