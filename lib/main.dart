import 'package:flutter/material.dart';
import 'package:learninformatics/screens/change_email_screen.dart';
import 'package:learninformatics/screens/change_password_screen.dart';
import 'package:learninformatics/screens/practical_list_screen.dart';
import 'package:learninformatics/screens/reset_password_screen.dart';
import 'package:learninformatics/screens/test_screen.dart';
import 'package:learninformatics/screens/testing_list_screen.dart';
import 'package:learninformatics/services/auth_services.dart';
import 'package:learninformatics/services/user.dart';
import 'package:learninformatics/screens/settings_screen.dart';
import 'package:learninformatics/screens/lecture_list_screen.dart';
import 'package:learninformatics/screens/login_screen.dart';
import 'package:learninformatics/screens/module_screen.dart';
import 'package:learninformatics/screens/registration_screen.dart';
import 'package:learninformatics/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

//ToDo: create fonts folder in android folder and put here Railway font
//ToDo: add dependencies in pubspec.yaml
//ToDo: add google-services.json in android/app folder

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthServices().user,
        child: MaterialApp(
          home: WelcomeScreen(),
          routes: {
            WelcomeScreen.id: (context) => WelcomeScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            ModuleScreen.id: (context) => ModuleScreen(),
            LectureListScreen.id: (context) => LectureListScreen(),
            SettingsScreen.id: (context) => SettingsScreen(),
            ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
            ChangePasswordScreen.id: (context) => ChangePasswordScreen(),
            ChangeEmailScreen.id: (context) => ChangeEmailScreen(),
            PracticalListScreen.id: (context) => PracticalListScreen(),
            TestingListScreen.id: (context) => TestingListScreen(),
            TestScreen.id: (context) => TestScreen(),
          },
        ));
  }
}
