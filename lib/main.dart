
import 'package:flutter/material.dart';


import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var title='WalMax';
    return MaterialApp(
      title: title,
debugShowCheckedModeBanner: false,
      theme: ThemeData(

         brightness: Brightness.dark,
      ),
      home:    SplashScreen(title:  title,),
    );
  }
}

