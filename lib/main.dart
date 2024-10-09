import 'package:flutter/material.dart';

import 'view/books_page.dart';

void main() => MyApp();


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BooksPage(),
    );
  }
}