import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/firebase_erros.dart';
import 'package:loja_virtual/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  late User? user; // Altere o tipo da variável para User?
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;

  Future<User?> signIn(
      {required UserModel user,
      required Function onFail,
      required Function onSucess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      onSucess();
      this.user = result.user;
      print('Logado com sucesso uid: ${this.user?.uid}');
      return result.user;
    } on FirebaseAuthException catch (e) {
      final erro = getFirebaseErrorString(e.code);
      onFail(erro);
    } catch (e) {
      // Qualquer outro erro que não seja uma exceção específica do FirebaseAuth
      onFail("Ocorreu um erro desconhecido ao tentar fazer login.");
    } finally {
      loading = false;
    }
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      user = currentUser;
      print(this.user?.uid);
    }
  }

  Future<void> signUp(
      {required UserModel user,
      required Function onFail,
      required Function onSucess}) async {
    try {
      loading = true;
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      this.user = result.user;
      onSucess();
      print('Cadastrado com sucesso uid: ${this.user?.uid}');
    } on FirebaseAuthException catch (e) {
      final erro = getFirebaseErrorString(e.code);
      onFail(erro);
    } catch (e) {
      // Qualquer outro erro que não seja uma exceção específica do FirebaseAuth
      onFail("Ocorreu um erro desconhecido ao tentar fazer o cadastro.");
    } finally {
      loading = false;
    }
  }
}
