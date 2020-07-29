import 'package:flutter/material.dart';
import 'package:learninformatics/components/rounded_button.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/services/auth_services.dart';
import 'package:learninformatics/services/text_validator.dart';

class ChangeEmailScreen extends StatefulWidget {
  static const String id = 'change_email_screen';
  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  AuthServices _authServices = AuthServices();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Смена email', //Change email
          style: kAppBarText,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Новый email'), //New email
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() => _email = value);
                      },
                      validator: TextValidator.emailValidator,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Текущий пароль', //Current password
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() => _showPassword = !_showPassword);
                          },
                          child: Icon(_showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      obscureText: !_showPassword,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() => _password = value);
                      },
                      validator: TextValidator.passwordValidator,
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    Builder(
                      builder: (BuildContext context) {
                        return RoundedButton(
                          buttonText: 'Сменить email', //Change email
                          color: Colors.blue,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              var result = await _authServices.changeEmail(
                                  password: _password, newEmail: _email);
                              if (result != null) {
                                Navigator.pop(context);
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Ошибка при попытке смены электронной почты'), // Error message
                                  ),
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
