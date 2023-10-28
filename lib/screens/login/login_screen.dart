import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/userModel.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, elevation: 0),
              child: const Text(
                'Criar Conta',
                style: TextStyle(fontSize: 14),
              ))
        ],
        backgroundColor: primaryColor,
      ),
      body: Center(
          child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        // usar uma listview aqui faz com que o usuario consiga rolar o card para cima caso a tela seja muito pequena

        child: Form(
            key: formKey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true, // faz ocupar a menor altura possivel
                children: <Widget>[
                  TextFormField(
                    enabled: !userManager.loading,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Insira um e-mail';
                      }
                      if (!emailValid(email)) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextFormField(
                    enabled: !userManager.loading,
                    controller: passController,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    obscureText: true,
                    validator: (pass) {
                      if (pass == null || pass.isEmpty) {
                        return 'Insira uma senha';
                      }
                      if (pass.length < 6) {
                        return 'A senha deve ter no minimo 6 caracteres';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.white,
                          elevation: 0),
                      onPressed: () {},
                      child: const Text(
                        'Esqueci minha senha',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 50,
                    child: userManager.loading
                        ? Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.blueAccent),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (!userManager.loading) {
                                if (formKey.currentState!.validate()) {
                                  context.read<UserManager>().signIn(
                                      onFail: (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Falha ao entrar: $e'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                      onSucess: () {
                                        log('Logado com sucesso');
                                        Navigator.of(context)
                                            .pushNamed('/base');
                                        // TODO: Fechar tela de login
                                      },
                                      user: UserModel(
                                          email: emailController.text,
                                          password: passController.text));
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                userManager.loading
                                    ? Colors.grey
                                    : Colors.indigo,
                              ),
                            ),
                            child: const Text(
                              'Entrar',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                  ),
                ],
              );
            })),
      )),
    );
  }
}

 //os campos estao bloqueados mesmo que loading seja false
