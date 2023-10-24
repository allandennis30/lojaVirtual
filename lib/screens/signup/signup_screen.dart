import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/userModel.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (name.trim().split(' ').length <= 1) {
                      return 'Preencha seu nome completo';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (!emailValid(email)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        // Alternar a visibilidade da senha
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (pass) {
                    if (pass == null || pass.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (pass.length < 6) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _confirmPassController,
                  decoration: InputDecoration(
                    hintText: 'Repita a Senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        // Alternar a visibilidade da senha de confirmação
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                  validator: (confirmPassword) {
                    if (confirmPassword == null || confirmPassword.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (confirmPassword.length < 6) {
                      return 'Senha muito curta';
                    } else if (confirmPassword != _passController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        UserModel user = UserModel(
                          email: _emailController.text,
                          password: _passController.text,
                          name: _nameController.text,
                          confirmPassword: _confirmPassController.text,
                        );

                        context.read<UserManager>().signUp(
                              user: user,
                              onFail: (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Falha ao cadadastrar: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                              onSucess: () {
                                debugPrint('Sucesso ao cadastrar');
                                //TODO: Fechar tela de cadastro
                              },
                            );

                        // Agora você pode usar 'user' para processar o registro do usuário.
                        // Navigator.of(context).pushReplacementNamed('/login');
                        print('criar conta');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
