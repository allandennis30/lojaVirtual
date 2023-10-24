import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String email;
  String password;
  String? name;
  String? confirmPassword;

  UserModel(
      {this.id,
      required this.email,
      required this.password,
      this.name,
      this.confirmPassword});

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
