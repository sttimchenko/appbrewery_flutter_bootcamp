import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  var leftDiceImagePath = _randomCardImagePath();
  var rightDiceImagePath = _randomCardImagePath();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
              child: FlatButton(
                onPressed: () {
                  _rollDices();
                },
                child: Image(
                  image: AssetImage(leftDiceImagePath),
                ),
              )
          ),
          Expanded(
              child: FlatButton(
                onPressed: () {
                  _rollDices();
                },
                child: Image(
                  image: AssetImage(rightDiceImagePath),
                ),
              )
          ),
        ],
      ),
    );
  }

  _rollDices() {
    setState(() {
      leftDiceImagePath = _randomCardImagePath();
      rightDiceImagePath = _randomCardImagePath();
    });
  }

  static String _randomCardImagePath() {
    return 'images/dice${Random().nextInt(5) + 1}.png';
  }
}
