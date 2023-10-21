import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/firebase_erros.dart';
import 'package:loja_virtual/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  Future<User?> signIn(
      {required UserModel user,
      required Function onFail,
      required Function onSucess}) async {
    setLoading(true);
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      onSucess();
      return result.user;
    } on FirebaseAuthException catch (e) {
      final erro = getFirebaseErrorString(e.code);
      onFail(erro);
      return null;
    } catch (e) {
      // Qualquer outro erro que não seja uma exceção específica do FirebaseAuth
      onFail("Ocorreu um erro desconhecido ao tentar fazer login.");
      setLoading(false);
      return null;
    }
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
