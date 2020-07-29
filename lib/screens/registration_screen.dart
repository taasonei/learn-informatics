import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learninformatics/components/styles.dart';
import 'package:learninformatics/components/rounded_button.dart';
import 'package:learninformatics/components/spinner.dart';
import 'package:learninformatics/screens/module_screen.dart';
import 'package:learninformatics/services/auth_services.dart';
import 'package:learninformatics/services/text_validator.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _showSpinner = false;
  bool _showPassword = false;
  AuthServices _authServices = AuthServices();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _firstName = '';
  String _lastName = '';
  String _patronymic = '';
  String _studentID = '';
  String _email = '';
  String _password = '';
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return _showSpinner
        ? Spinner()
        : Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Фамилия'),
                              textAlign: TextAlign.center,
                              textCapitalization: TextCapitalization.words,
                              inputFormatters: [
                                WhitelistingTextInputFormatter(
                                    RegExp('[а-яА-Я-]'))
                              ],
                              onChanged: (value) {
                                setState(() => _lastName = value);
                              },
                              validator: (val) =>
                                  TextValidator.isEmptyValidator(
                                      val, 'фамилию'),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Имя'),
                              textAlign: TextAlign.center,
                              textCapitalization: TextCapitalization.words,
                              inputFormatters: [
                                WhitelistingTextInputFormatter(
                                    RegExp('[а-яА-Я-]'))
                              ],
                              onChanged: (value) {
                                setState(() => _firstName = value);
                              },
                              validator: (val) =>
                                  TextValidator.isEmptyValidator(val, 'имя'),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Отчество'),
                              textAlign: TextAlign.center,
                              textCapitalization: TextCapitalization.words,
                              inputFormatters: [
                                WhitelistingTextInputFormatter(
                                    RegExp('[а-яА-Я]'))
                              ],
                              onChanged: (value) {
                                setState(() => _patronymic = value);
                              },
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              decoration: kTextFieldDecoration.copyWith(
                                  labelText: '№ студ. билета',
                                  hintText: '1БВТ-11111'),
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                setState(() => _studentID = value);
                              },
                              validator: (val) =>
                                  TextValidator.isEmptyValidator(
                                      val, '№ студ. билета'),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Email'),
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
                                labelText: 'Пароль',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(
                                        () => _showPassword = !_showPassword);
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
                            RoundedButton(
                              buttonText: 'Зарегистрироваться', // Register
                              color: Colors.blue,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => _showSpinner = true);
                                  try {
                                    dynamic user = await _authServices
                                        .registerWithEmailAndPassword(
                                            email: _email,
                                            password: _password,
                                            firstName: _firstName,
                                            lastName: _lastName,
                                            patronymic: _patronymic ?? '',
                                            studentID: _studentID);
                                    if (user != null) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ModuleScreen(
                                              isAuthenticated:
                                                  !user.isAnonymous,
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
                                    _errorText = e.toString();
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              _errorText,
                              style:
                                  kCardSubtitleText.copyWith(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          );
  }
}
