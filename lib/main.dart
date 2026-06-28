import 'package:flutter/material.dart';

// import 'pages/login_page.dart'; // Ensure this path is correct and LoginPage is defined in login_page.dart
import 'pages/splash_page.dart';

void main() {
  runApp(const WisataApp());
}

class WisataApp extends StatelessWidget {
  const WisataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WisataGo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const SplashPage(), // Ensure SplashPage is a defined class in splash_page.dart
    );
  }
}
