import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quizzler/quiz_brain.dart';

final quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  var scoreKeeper = <bool>[];

  checkAnswer(bool answer) {
    if (quizBrain.isFinished()) {
      resetAction() {
        setState(() {
          scoreKeeper.clear();
          quizBrain.reset();
          Navigator.pop(context);
        });
      }

      Alert(
          context: context,
          type: AlertType.none,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          style: AlertStyle(
              isOverlayTapDismiss: false
          ),
          closeFunction: () {
            resetAction();
          },
          buttons: [
            DialogButton(
              child: Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                resetAction();
              },
            )
          ]
      ).show();
    }

    setState(() {
      scoreKeeper.add(quizBrain.getQuestionAnswer() == answer);
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        ScoreKeeper(scores: scoreKeeper,)
      ],
    );
  }
}

class ScoreKeeper extends StatelessWidget {
  final List<bool> scores;

  ScoreKeeper({@required this.scores}) : assert(scores != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: scores.map((isCorrect) {
        return Icon(
          isCorrect ? Icons.check : Icons.close,
          color: isCorrect ? Colors.green : Colors.red,
        );
      }).toList(),
    );
  }
}


/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
