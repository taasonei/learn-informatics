import 'package:flutter/material.dart';
import 'package:learninformatics/components/reusable_cards.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/screens/test_screen.dart';

class TestingListScreen extends StatefulWidget {
  static const String id = 'testing_list_screen';

  @override
  _TestingListScreenState createState() => _TestingListScreenState();
}

class _TestingListScreenState extends State<TestingListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Тесты. Модуль 1', // Test. Module 1
          style: kAppBarText,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            EnabledCard(
              title: 'Тест к лекции 1', // Test for lecture 1
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen(
                            lectureNumber: 1,
                          )),
                );
              },
              enabled: true,
            ),
            EnabledCard(
              title: 'Тест к лекции 2',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen(
                            lectureNumber: 2,
                          )),
                );
              },
              enabled: true,
            ),
            EnabledCard(
              title: 'Тест к лекции 3',
              enabled: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen(
                            lectureNumber: 3,
                          )),
                );
              },
            ),
            EnabledCard(
              title: 'Тест к лекции 4',
              enabled: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen(
                            lectureNumber: 4,
                          )),
                );
              },
            ),
            EnabledCard(
              title: 'Тест к лекции 5',
              enabled: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen(
                            lectureNumber: 5,
                          )),
                );
              },
            ),
            EnabledCard(
              title: 'Тест к лекции 6',
              enabled: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen(
                            lectureNumber: 6,
                          )),
                );
              },
            ),
            EnabledCard(
              title: 'Тест к лекции 7',
              enabled: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen(
                            lectureNumber: 7,
                          )),
                );
              },
            ),
            EnabledCard(
              title: 'Тест к лекции 8',
              enabled: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TestScreen(
                            lectureNumber: 8,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
