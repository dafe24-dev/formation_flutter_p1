import 'package:flutter/material.dart';
import 'package:groupe2/pages/tabmenu.dart';
import 'package:groupe2/pages/carrousel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TabMenu & Carrousels",
      debugShowCheckedModeBanner: false,
      home: TabMenu(),
    );
  }
}
