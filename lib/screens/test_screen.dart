import 'package:flutter/material.dart';
import 'package:learninformatics/components/rounded_button.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learninformatics/screens/testing_list_screen.dart';
import 'package:learninformatics/services/quiz.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TestScreen extends StatefulWidget {
  static const String id = 'test_screen';
  TestScreen({this.lectureNumber});
  int lectureNumber;
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final CollectionReference testCollection =
      Firestore.instance.collection('test');
  Quiz quiz;
  int _selectedRadio = 0;
  int _correctAnswers = 0;
  int _questionNumber = 0;
  List<Answer> answerList = List<Answer>(4);
  String questionText;
  bool _isWaiting = false;

  void getData({int questionNumber}) async {
    _isWaiting = true;
    try {
      await testCollection
          .document('lecture${widget.lectureNumber}')
          .get()
          .then((value) => {
                quiz = Quiz.fromMap(value.data),
              });
      Question question = quiz.questions[questionNumber];
      _isWaiting = false;
      setState(() {
        questionText = question.questionText;
        answerList = [
          question.answers[0],
          question.answers[1],
          question.answers[2],
          question.answers[3],
        ];
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData(questionNumber: 0);
  }

  void setSelectedRadio(int val) {
    setState(() {
      _selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Тест Л${widget.lectureNumber}', // Test. Lecture ${lectureNumber}
          style: kAppBarText,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _isWaiting ? '?' : questionText,
                style: kCardTitleText.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            //Divider(),
            RadioListTile(
              value: 1,
              groupValue: _selectedRadio,
              title: Text(_isWaiting ? '?' : answerList[0].answerText),
              onChanged: (val) => setSelectedRadio(val),
            ),
            Divider(),
            RadioListTile(
              value: 2,
              groupValue: _selectedRadio,
              title: Text(_isWaiting ? '?' : answerList[1].answerText),
              onChanged: (val) => setSelectedRadio(val),
            ),
            Divider(),
            RadioListTile(
              value: 3,
              groupValue: _selectedRadio,
              title: Text(_isWaiting ? '?' : answerList[2].answerText),
              onChanged: (val) => setSelectedRadio(val),
            ),
            Divider(),
            RadioListTile(
              value: 4,
              groupValue: _selectedRadio,
              title: Text(_isWaiting ? '?' : answerList[3].answerText),
              onChanged: (val) => setSelectedRadio(val),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedButton(
                buttonText: 'Далее', // Next
                color: Colors.blue,
                onPressed: () {
                  setState(
                    () {
                      if (answerList[_selectedRadio - 1].correct) {
                        _correctAnswers++;
                      }
                      if (_questionNumber < 4) {
                        _questionNumber++;
                        _selectedRadio = 0;
                        getData(questionNumber: _questionNumber);
                      } else {
                        Alert(
                            context: context,
                            type: AlertType.none,
                            title: 'Тест окончен', // Test is over
                            desc:
                                'Вы дали правильный ответ на $_correctAnswers из 5 вопросов', // Your answered $_correctAnswers out of 5 questions correctly
                            buttons: [
                              DialogButton(
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => Navigator.popUntil(context,
                                    ModalRoute.withName(TestingListScreen.id)),
                              )
                            ]).show();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
