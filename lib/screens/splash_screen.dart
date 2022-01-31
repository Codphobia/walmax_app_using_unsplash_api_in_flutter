import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:walmax/screens/topic_list_screen.dart';

class SplashScreen extends StatefulWidget {
  final String title;

  const SplashScreen({Key? key, required this.title}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TopicListScreen(
              title: widget.title,
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            // ignore: use_full_hex_values_for_flutter_colors
            Color(0xf0e0023),
            Color(0xff3a1e54),
          ],
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
            duration: Duration(seconds: 5),
            size: 200,
          ),
        ),
      ),
    );
  }
}
