import 'package:flutter/material.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/components/rounded_button.dart';
import 'package:learninformatics/components/spinner.dart';
import 'package:learninformatics/screens/module_screen.dart';
import 'package:learninformatics/screens/reset_password_screen.dart';
import 'package:learninformatics/services/auth_services.dart';
import 'package:learninformatics/services/text_validator.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthServices _authServices = AuthServices();
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';
  bool _showPassword = false;
  bool _showSpinner = false;
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return _showSpinner
        ? Spinner()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            kTextFieldDecoration.copyWith(labelText: 'Email'),
                        validator: TextValidator.emailValidator,
                        onChanged: (value) {
                          setState(() => _email = value);
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: !_showPassword,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Пароль', // Password
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() => _showPassword = !_showPassword);
                            },
                            child: Icon(_showPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() => _password = value);
                        },
                        validator: TextValidator.passwordValidator,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      RoundedButton(
                        buttonText: 'Войти', // Log in
                        color: Colors.blue,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => _showSpinner = true);
                            try {
                              dynamic user = await _authServices
                                  .signInWithEmailAndPassword(
                                      _email, _password);

                              if (user != null) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ModuleScreen(
                                        isAuthenticated: !user.isAnonymous,
                                      ),
                                    ),
                                    (route) => false);
                              } else {
                                setState(() {
                                  _showSpinner = false;
                                  _errorText =
                                      'Ошибка. Проверьте корректность введенных данных'; // Error message
                                });
                              }
                            } catch (e) {
                              print(e.toString());
                              setState(() {
                                _errorText = e.toString();
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      FlatButton(
                        child: Text(
                          'Забыли пароль?', //Forgot your password?
                          style: kCardSubtitleText.copyWith(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, ResetPasswordScreen.id);
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
            ),
          );
  }
}
