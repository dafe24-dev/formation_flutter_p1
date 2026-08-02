import 'package:contact_pro/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F5F7),
        fontFamily: 'Roboto',
        
      ),
      home: const LoginPage()
    );
  }
}

