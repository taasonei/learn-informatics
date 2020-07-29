import 'package:flutter/material.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/screens/lecture_list_screen.dart';
import 'package:learninformatics/screens/practical_list_screen.dart';
import 'package:learninformatics/screens/settings_screen.dart';
import 'package:learninformatics/components/reusable_cards.dart';
import 'package:learninformatics/screens/testing_list_screen.dart';
import 'package:learninformatics/screens/welcome_screen.dart';
import 'package:learninformatics/services/auth_services.dart';
import 'dart:convert' show utf8;
import 'package:learninformatics/screens/webview_screen.dart';

class ModuleScreen extends StatefulWidget {
  static const String id = 'module_screen';
  ModuleScreen({this.isAuthenticated});
  final bool isAuthenticated;

  @override
  _ModuleScreenState createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Информатика', // Computer Science
          style: kAppBarText,
        ),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                tooltip: 'Настройки профиля', // Profile settings
                icon: Icon(Icons.settings),
                onPressed: () {
                  if (widget.isAuthenticated) {
                    Navigator.pushNamed(context, SettingsScreen.id);
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                          'Доступно только зарегистрированным пользователям'), // Valid only for not anonymous users
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                },
              );
            },
          ),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              tooltip: 'Выход', // Sign out
              onPressed: () async {
                await _authServices.signOut();
                Navigator.popAndPushNamed(context, WelcomeScreen.id);
              }),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              EnabledCard(
                title: 'Лекции', // Lectures
                onTap: () {
                  Navigator.pushNamed(context, LectureListScreen.id);
                },
                enabled: true,
              ),
              EnabledCard(
                title: 'Практика', // Practice tasks
                onTap: () {
                  Navigator.pushNamed(context, PracticalListScreen.id);
                },
                enabled: widget.isAuthenticated,
              ),
              EnabledCard(
                title: 'Тесты', // Tests
                onTap: () {
                  Navigator.pushNamed(context, TestingListScreen.id);
                },
                enabled: widget.isAuthenticated,
              ),
              EnabledCard(
                title:
                    'Вопросы для подготовки к промежуточной аттестации', // Exam questions
                onTap: () {
                  //ToDo: put here a link for a exam questions file from Firebase Storage
                  const url = '';
                  var decodedUrl = utf8.decode(utf8.encode(url));
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => WebViewScreen(
                        title: 'Вопросы', // Questions
                        selectedUrl:
                            'https://drive.google.com/viewerng/viewer?embedded=true&url=' +
                                decodedUrl,
                      ),
                    ),
                  );
                },
                enabled: widget.isAuthenticated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
