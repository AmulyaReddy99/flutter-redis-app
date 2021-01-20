import 'package:flutter/material.dart';
import 'package:flutter_redis_app/pages/main-page.dart';
import 'package:redis/redis.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FlutterRedisApp());
}

class FlutterRedisApp extends StatefulWidget {
  _FlutterRedisApp createState() => _FlutterRedisApp();
  // FlutterRedisApp() {
  //   RedisConnection conn = new RedisConnection();
  //   conn.connect('localhost',6379);
  // }
}

class _FlutterRedisApp extends State<FlutterRedisApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
        setState(() {
          _initialized = true;
        });
      } catch(e) {
        setState(() {
          _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_error) {
      print("ERROR in connecting to database");
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Redis Page',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: MainPage(),
    );
  }
}