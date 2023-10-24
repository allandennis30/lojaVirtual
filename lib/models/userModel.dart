import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String email;
  String? password;
  String? name;
  String? confirmPassword;

  UserModel({
    this.id,
    required this.email,
    this.password,
    this.name,
    this.confirmPassword,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      email: doc['email'] as String,
      name: doc['name'] as String,
    );
  }

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
