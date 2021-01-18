import 'package:flutter/material.dart';
import 'package:flutter_redis_app/pages/main-page.dart';

void main() {
  runApp(FlutterRedisApp());
}

class FlutterRedisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Redis Page',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MainPage(),
    );
  }
}