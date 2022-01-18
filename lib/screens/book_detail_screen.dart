import 'package:flutter/material.dart';

class BookDetailScreen extends StatefulWidget {
  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Detail"),
      ),
    );
  }
}
