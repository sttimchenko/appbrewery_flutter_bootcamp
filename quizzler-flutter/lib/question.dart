import 'package:flutter/cupertino.dart';

class Question {
  String questionText;
  bool questionAnswer;

  Question(this.questionText, this.questionAnswer)
      : assert(questionText != null),
        assert(questionAnswer != null);
}
