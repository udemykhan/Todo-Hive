import 'package:flutter/material.dart';
import 'pages/homePage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  //initialize Hive
  await Hive.initFlutter();
  // open the box
  var box = await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: const HomePage(),
    );
  }
}
