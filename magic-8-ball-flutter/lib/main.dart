import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: BallPage(),
    ),
  );
}

class BallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Ask Me Anything'),
      ),
      body: Ball()
    );
  }
}

class Ball extends StatefulWidget {
  @override
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball> {
  var ballImagePath = _getRandomImagePath();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: FlatButton(
          onPressed: () {
            setState(() {
              ballImagePath = _getRandomImagePath();
            });
          },
          child: Image.asset(ballImagePath),
        ),
      ),
    );
  }

  static String _getRandomImagePath() {
    return 'images/ball${Random().nextInt(4) + 1}.png';
  }
}

