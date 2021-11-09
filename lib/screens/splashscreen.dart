import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mod3_kel03/screens/responsi.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const ResponsiPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 200,
        ),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'res/storm_trooper.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Anime App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
