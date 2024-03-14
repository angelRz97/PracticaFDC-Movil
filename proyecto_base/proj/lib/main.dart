import 'package:flutter/material.dart';
import 'package:proj/s1.dart';
import '/principal.dart';
import 's2.dart';
import 's3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, initialRoute: '/principal', routes: {
      '/principal': (BuildContext context) => Principal(),
      '/screen1': (BuildContext context) => S1(),
      '/screen2': (BuildContext context) => S2(),
      '/screen3': (BuildContext context) => S3(),
    });
  }
}
