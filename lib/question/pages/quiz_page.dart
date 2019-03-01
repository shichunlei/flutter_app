import 'package:flutter/material.dart';
import 'package:flutter_app/question/bean/question.dart';
import 'package:flutter_app/question/bean/quiz.dart';
import 'package:flutter_app/question/pages/score_page.dart';
import 'package:flutter_app/question/ui/answer_button.dart';
import 'package:flutter_app/question/ui/correct_wrong_overlay.dart';
import 'package:flutter_app/question/ui/question_test.dart';
import 'package:flutter_app/utils/route_util.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Question currectQuestion;
  Quiz quiz = Quiz([
    Question("Elon Musk is human", false),
    Question("Pizza is healthy", true),
    Question("Flutter is awesome", true),
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;

  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();

    currectQuestion = quiz.nextQuestion;
    questionText = currectQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currectQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // 填满屏幕
      children: <Widget>[
        Column(
          children: <Widget>[
            AnswerButton(true, () {
              print("You answerd Ture");
              handleAnswer(true);
            }),
            QuestionTest(questionText, questionNumber),
            AnswerButton(false, () {
              print("You answerd False");
              handleAnswer(false);
            }),
          ],
        ),
        overlayShouldBeVisible
            ? CorrectWrongOverlay(
                isCorrect,
                () {
                  if (quiz.length == questionNumber) {
                    pushAndRemovePage(
                        context, ScorePage(quiz.score, quiz.length));
                  } else {
                    currectQuestion = quiz.nextQuestion;
                    this.setState(() {
                      overlayShouldBeVisible = false;
                      questionText = currectQuestion.question;
                      questionNumber = quiz.questionNumber;
                    });
                  }
                },
              )
            : Container(),
      ],
    );
  }
}
