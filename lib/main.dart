import 'package:flutter/material.dart';
import 'package:tabbar_trying/tabbar_animation/tabbar_animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: TabbarAnimation(),
    );
  }
}