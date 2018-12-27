import 'package:flutter/material.dart';

import 'package:here/service_locator.dart';
import 'package:here/views/screens/main_page.dart';

void main() {
  setup();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Here',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

