import 'package:flutter/material.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/components/reusable_cards.dart';

class PracticalListScreen extends StatefulWidget {
  static const String id = 'practical_list_screen';
  @override
  _PracticalListScreenState createState() => _PracticalListScreenState();
}

class _PracticalListScreenState extends State<PracticalListScreen> {
  Map<int, String> _practicePDF = {
    //ToDo: put here links for documents with practical tasks from Firebase Storage
    1: '',
    2: '',
    3: '',
    4: '',
    5: '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Модуль 1', // Module 1
          style: kAppBarText,
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            URLCard(
              title: 'Занятие 1', // Lesson 1
              subtitle:
                  'Перевод чисел из одной позиционной системы счисления в другую', // Practice lesson description
              url: _practicePDF[1],
            ),
            URLCard(
              title: 'Занятие 2',
              subtitle: 'Двоичная арифметика',
              url: _practicePDF[2],
            ),
            URLCard(
              title: 'Занятие 3',
              subtitle: 'Основы машинной арифметики',
              url: _practicePDF[3],
            ),
            URLCard(
              title: 'Занятие 4',
              subtitle: 'Логические операции',
              url: _practicePDF[4],
            ),
            URLCard(
              title: 'Занятие 5',
              subtitle: 'Равносильность формул',
              url: _practicePDF[5],
            ),
          ],
        ),
      ),
    );
  }
}
