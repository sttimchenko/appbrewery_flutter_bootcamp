import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text('I Am Poor'),
        ),
        body: Center(
          child: Image.asset('images/card.png'),
        ),
      ),
    ),
  );
}