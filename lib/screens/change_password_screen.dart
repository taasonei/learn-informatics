import 'package:flutter/material.dart';
import 'package:learninformatics/components/rounded_button.dart';
import 'package:learninformatics/services/auth_services.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/services/text_validator.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String id = 'change_password_screen';
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  AuthServices _authServices = AuthServices();
  final _formKey = GlobalKey<FormState>();
  String _oldPassword;
  String _newPassword;
  bool _showOldPassword = false;
  bool _showNewPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Смена пароля', // Change password
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
                        labelText: 'Текущий пароль', // Current password
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(
                                () => _showOldPassword = !_showOldPassword);
                          },
                          child: Icon(_showOldPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      obscureText: !_showOldPassword,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() => _oldPassword = value);
                      },
                      validator: TextValidator.passwordValidator,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Новый пароль', // New password
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(
                                () => _showNewPassword = !_showNewPassword);
                          },
                          child: Icon(_showNewPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                      obscureText: !_showNewPassword,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() => _newPassword = value);
                      },
                      validator: TextValidator.passwordValidator,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Builder(builder: (BuildContext context) {
                      return RoundedButton(
                        color: Colors.blue,
                        buttonText: 'Сменить пароль', // Change password
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var result = await _authServices.changePassword(
                                newPassword: _newPassword,
                                oldPassword: _oldPassword);
                            if (result != null) {
                              Navigator.pop(context);
                            } else {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Ошибка при попытке смены пароля'), // Error message
                                ),
                              );
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
        ),
      ),
    );
  }
}
