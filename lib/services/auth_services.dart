import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learninformatics/services/database_services.dart';
import 'package:learninformatics/services/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // создаем объект User основанный на FirebaseUser
  // create User object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, isAnonymous: user.isAnonymous)
        : null;
  }

  Future<FirebaseUser> get getUser => _auth.currentUser();

  // stream/поток изменения статуса аутентификации (пользователь залогинен/разлогинен)
  // user authentications status change stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // анонимный вход (регистрация анонимного гостевого аккаунта)
  // sign in anonymously (register anonymous guest account)
  Future signInAnonymously() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // регистрация email + пароль + данные пользователя
  // register a new user with email, password and users's data
  Future registerWithEmailAndPassword(
      {String email,
      String password,
      String firstName,
      String patronymic,
      String lastName,
      String studentID}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseServices(uid: user.uid).updateUserData(
          email: email,
          firstName: firstName,
          lastName: lastName,
          patronymic: patronymic,
          studentID: studentID);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // войти с email + пароль
  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // выход. удаление анонимного акка при выходе
  // sign out. delete user's account if it is anonymous
  Future signOut() async {
    FirebaseUser user = await _auth.currentUser();
    if (user.isAnonymous) {
      try {
        await user.delete();
        return 'deleted';
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      try {
        await _auth.signOut();
        return 'deleted';
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  }

  // сброс пароля
  // reset password
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'succeed';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // смена пароля
  // change password
  Future changePassword({String oldPassword, String newPassword}) async {
    try {
      // создать instance текущего пользователя
      // create an instance of a current user
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      // ре-аутентификация пользователя с текущим паролем
      // user reauthorises with current password
      AuthCredential authCredential = EmailAuthProvider.getCredential(
          email: user.email, password: oldPassword);
      await user.reauthenticateWithCredential(authCredential);
      // передать новый пароль в updatePassword
      // transwer a new password to updatePassword
      await user.updatePassword(newPassword);
      return 'succeed';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // смена email
  // change email
  Future changeEmail({String password, String newEmail}) async {
    try {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      AuthCredential authCredential = EmailAuthProvider.getCredential(
          email: user.email, password: password);
      await user.reauthenticateWithCredential(authCredential);
      await user.updateEmail(newEmail);

      await Firestore.instance.collection('users').document(user.uid).setData({
        'email': newEmail,
      }, merge: true);
      return 'succeed';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
