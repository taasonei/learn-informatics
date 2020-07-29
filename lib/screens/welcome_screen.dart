import 'package:flutter/material.dart';
import 'package:learninformatics/components/rounded_button.dart';
import 'package:learninformatics/components/spinner.dart';
import 'package:learninformatics/screens/login_screen.dart';
import 'package:learninformatics/screens/module_screen.dart';
import 'package:learninformatics/screens/registration_screen.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/services/auth_services.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showSpinner = false;
  AuthServices _authServices = AuthServices();
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    _authServices.getUser.then(
      (user) {
        if (user != null) {
          goToModuleScreen(!user.isAnonymous);
        }
      },
    );
  }

  void goToModuleScreen(bool isAuthenticated) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ModuleScreen(
            isAuthenticated: isAuthenticated,
          ),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return _showSpinner
        ? Spinner()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Информатика', // Computer Science
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 75.0,
                    ),
                    RoundedButton(
                      buttonText: 'Вход', // Login
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    RoundedButton(
                      buttonText: 'Регистрация', // Register
                      color: Colors.lightBlueAccent,
                      onPressed: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    FlatButton(
                      child: Text(
                        'Войти без учетной записи', // Sign in anonymously
                        style: kCardSubtitleText.copyWith(color: Colors.blue),
                      ),
                      onPressed: () async {
                        setState(() => _showSpinner = true);
                        try {
                          dynamic user =
                              await _authServices.signInAnonymously();
                          if (user != null) {
                            goToModuleScreen(!user.isAnonymous);
                          } else {
                            setState(() {
                              _showSpinner = false;
                              _errorText =
                                  'Ошибка. Проверьте корректность введенных данных'; // Error message
                            });
                          }
                        } catch (e) {
                          print(e.toString());
                          _errorText = e.toString();
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      _errorText,
                      style: kCardSubtitleText.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
