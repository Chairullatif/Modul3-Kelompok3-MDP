import 'package:flutter/material.dart';
import 'package:mod3_kel03/screens/home.dart';
import 'package:mod3_kel03/screens/detail.dart';
import 'package:mod3_kel03/screens/responsi.dart';
import 'package:mod3_kel03/screens/splashscreen.dart';

void main() async {
  runApp(const AnimeApp());
}

class AnimeApp extends StatelessWidget {
  const AnimeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime app',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(item: 0, title: ''),
        '/responsi': (context) => const ResponsiPage(),
      },
    );
  }
}
