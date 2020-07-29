import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learninformatics/components/rounded_button.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/components/spinner.dart';
import 'package:learninformatics/screens/change_email_screen.dart';
import 'package:learninformatics/screens/change_password_screen.dart';
import 'package:learninformatics/services/database_services.dart';
import 'package:learninformatics/services/text_validator.dart';
import 'package:learninformatics/services/user.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  String _currentFirstName;
  String _currentLastName;
  String _currentPatronymic;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        //Firestore.instance.collection('users').document(user.uid)
        stream: DatabaseServices(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData && !snapshot.hasError) {
            String _currentEmail = '';

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Настройки', // Settings
                  style: kAppBarText,
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            initialValue: userData.lastName,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Фамилия'),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(
                                  RegExp('[а-яА-Я-]'))
                            ],
                            validator: (val) =>
                                TextValidator.isEmptyValidator(val, 'фамилию'),
                            onChanged: (val) =>
                                setState(() => _currentLastName = val),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            initialValue: userData.firstName,
                            decoration:
                                kTextFieldDecoration.copyWith(labelText: 'Имя'),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(
                                  RegExp('[а-яА-Я-]'))
                            ],
                            validator: (val) =>
                                TextValidator.isEmptyValidator(val, 'имя'),
                            onChanged: (val) =>
                                setState(() => _currentFirstName = val),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            initialValue: userData.patronymic,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Отчество'),
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp('[а-яА-Я]'))
                            ],
                            onChanged: (val) =>
                                setState(() => _currentPatronymic = val),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            initialValue: userData.studentID,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: '№ студ. билета'),
                            textAlign: TextAlign.center,
                            enabled: false,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            initialValue: userData.email,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Email'),
                            textAlign: TextAlign.center,
                            readOnly: true,
                            onTap: () {
                              setState(() {
                                _currentEmail = userData.email;
                              });
                              Navigator.pushNamed(
                                  context, ChangeEmailScreen.id);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            initialValue: 'password',
                            obscureText: true,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Пароль'),
                            textAlign: TextAlign.center,
                            readOnly: true,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ChangePasswordScreen.id);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Builder(builder: (BuildContext context) {
                            return RoundedButton(
                              buttonText: 'Сохранить', // Save the changes
                              color: Colors.blue,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    await DatabaseServices(uid: user.uid)
                                        .updateUserData(
                                      firstName: _currentFirstName ??
                                          userData.firstName,
                                      lastName:
                                          _currentLastName ?? userData.lastName,
                                      patronymic: _currentPatronymic ??
                                          userData.patronymic,
                                      studentID: userData.studentID,
                                      email: userData.email,
                                    );
                                    Navigator.pop(context);
                                  } catch (e) {
                                    print(e.toString());
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Ошибка. Попробуйте позднее'), // Error message
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
            );
          } else {
            return Spinner();
          }
        });
  }
}
