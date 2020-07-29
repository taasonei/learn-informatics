class User {
  final String uid;
  final bool isAnonymous;
  User({this.uid, this.isAnonymous});
}

class UserData {
  final String uid;
  final String email;
  final String firstName;
  final String patronymic;
  final String lastName;
  final String studentID;

  UserData(
      {this.uid,
      this.email,
      this.firstName,
      this.patronymic,
      this.lastName,
      this.studentID});
}
