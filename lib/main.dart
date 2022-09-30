import 'package:flutter/material.dart';
import 'package:my_cash_book_flutter/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "My Cash Book",
      home: LoginScreen(),
    );
  }
}
