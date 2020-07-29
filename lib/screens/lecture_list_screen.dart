import 'package:flutter/material.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/components/reusable_cards.dart';

class LectureListScreen extends StatefulWidget {
  static const String id = 'lecture_list_screen';
  @override
  _LectureListScreenState createState() => _LectureListScreenState();
}

class _LectureListScreenState extends State<LectureListScreen> {
  Map<int, String> _lecturesPDF = {
    //ToDo: put links for lectures from Firebase Storage in single quotes
    1: '',
    2: '',
    3: '',
    4: '',
    5: '',
    6: '',
    7: '',
    8: '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Модуль 1', style: kAppBarText), // Module 1
      ),
      body: SafeArea(
        child: ListView(
          children: [
            URLCard(
              title: 'Лекция 1', // Lecture 1
              subtitle:
                  'Информация, информатика, информационные технологии', // Lecture description
              url: _lecturesPDF[1],
            ),
            URLCard(
              title: 'Лекция 2',
              subtitle:
                  'Технические средства реализации информационных процессов',
              url: _lecturesPDF[2],
            ),
            URLCard(
              title: 'Лекция 3',
              subtitle: 'Системное программное обеспечение',
              url: _lecturesPDF[3],
            ),
            URLCard(
              title: 'Лекция 4',
              subtitle: 'Прикладное программное обеспечение',
              url: _lecturesPDF[4],
            ),
            URLCard(
              title: 'Лекция 5',
              subtitle: 'Модели решения функциональных и вычислительных задач',
              url: _lecturesPDF[5],
            ),
            URLCard(
              title: 'Лекция 6',
              subtitle: 'Основы алгоритмизации и технологии программирования',
              url: _lecturesPDF[6],
            ),
            URLCard(
              title: 'Лекция 7',
              subtitle: 'Компьютерные сети',
              url: _lecturesPDF[7],
            ),
            URLCard(
              title: 'Лекция 8',
              subtitle: 'Основы и методы защиты информации',
              url: _lecturesPDF[8],
            ),
          ],
        ),
      ),
    );
  }
}
