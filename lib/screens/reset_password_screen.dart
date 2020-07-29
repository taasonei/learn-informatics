import 'package:flutter/material.dart';
import 'package:learninformatics/components/rounded_button.dart';
import 'package:learninformatics/services/auth_services.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/services/text_validator.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password_screen';
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String _email = '';
  AuthServices _authServices = AuthServices();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Сброс пароля',
          style: kAppBarText,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    'Введите адрес электронной почты, на которую придет ссылка для смены пароля', // Enter email to reset your password
                    textAlign: TextAlign.justify,
                    style: kCardSubtitleText.copyWith(
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() => _email = value);
                  },
                  validator: TextValidator.emailValidator,
                ),
                SizedBox(
                  height: 32.0,
                ),
                Builder(builder: (BuildContext context) {
                  return RoundedButton(
                    color: Colors.blue,
                    buttonText: 'Сбросить пароль', // Reset password
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        try {
                          var reset = await _authServices.resetPassword(_email);
                          if (reset != null) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'На вашу почту отправлено письмо для  смены пароля'), // Email with instructions has been sent
                              ),
                            );
                          } else {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Ошибка сброса пароля. Проверьте корректность введеного email'), // Error message
                              ),
                            );
                          }
                        } catch (e) {
                          print(e.toString());
                        }
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
