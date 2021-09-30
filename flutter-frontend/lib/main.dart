import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:vehical_info_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Builder(builder: (context) {
          return Column(
            children: const [
              Icon(
                Icons.commute_outlined,
                size: 55,
              ),
              Text(
                "VehicalInfo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }),
        nextScreen: const MyHomePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
