import 'package:flutter/cupertino.dart';

class Story {
  String storyTitle;
  String firstChoice;
  String secondChoice;

  Story({
    @required this.storyTitle,
    @required this.firstChoice,
    @required this.secondChoice
  }) : assert(storyTitle != null),
        assert(firstChoice != null),
        assert(secondChoice != null);
}
