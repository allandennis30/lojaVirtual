import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/firebase_erros.dart';
import 'package:loja_virtual/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    user = null; // Initialize user as null
    _loadCurrentUser();
  }

  UserModel? user;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => user != null;

  Future<User?> signIn({
    required UserModel user,
    required Function onFail,
    required Function onSucess,
  }) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );

      onSucess();

      await _loadCurrentUser(firebaseUser: auth.currentUser);
      return result.user;
    } on FirebaseAuthException catch (e) {
      final erro = getFirebaseErrorString(e.code);
      onFail(erro);
    } catch (e) {
      onFail("Ocorreu um erro desconhecido ao tentar fazer login.");
    } finally {
      loading = false;
    }
    return null;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? firebaseUser}) async {
    final User? currentUser = firebaseUser ?? auth.currentUser;

    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();

      if (docUser.exists) {
        user = UserModel.fromDocument(docUser);
      } else {
        // Handle the case where the document does not exist
      }
      print('Nome cadastrado : ${user?.name}');
      notifyListeners();
    }
  }

  Future<void> signUp({
    required UserModel userModel,
    required Function onFail,
    required Function onSucess,
  }) async {
    try {
      loading = true;
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password!,
      );

      userModel.id = result.user?.uid;
      user = userModel;

      await userModel.saveData();
      onSucess();

      print('Cadastrado com sucesso uid: ${result.user?.uid}');
    } on FirebaseAuthException catch (e) {
      final erro = getFirebaseErrorString(e.code);
      onFail(erro);
    } catch (e) {
      onFail("Ocorreu um erro desconhecido ao tentar fazer o cadastro.");
    } finally {
      loading = false;
    }
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }
}
