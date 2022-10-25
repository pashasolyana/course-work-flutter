import 'package:flutter/material.dart';
import 'package:myapp/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title : 'Currency converter',
      theme : ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home : const MainPage(),
    );
  }
}
