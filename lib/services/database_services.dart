import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learninformatics/services/user.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});

  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future updateUserData(
      {String email,
      String firstName,
      String patronymic,
      String lastName,
      String studentID}) async {
    return await usersCollection.document(uid).setData({
      'email': email,
      'firstName': firstName,
      'patronymic': patronymic,
      'lastName': lastName,
      'studentID': studentID,
    });
  }

  DocumentReference getData(String uid) {
    return usersCollection.document(uid);
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      email: snapshot.data['email'],
      firstName: snapshot.data['firstName'],
      patronymic: snapshot.data['patronymic'],
      lastName: snapshot.data['lastName'],
      studentID: snapshot.data['studentID'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
