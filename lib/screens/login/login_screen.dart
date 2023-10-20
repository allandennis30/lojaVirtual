import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Center(
          child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        // usar uma listview aqui faz com que o usuario consiga rolar o card para cima caso a tela seja muito pequena
        child: ListView(
          padding: const EdgeInsets.all(16),

          shrinkWrap: true, // faz ocupar a menor altura possivel
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              validator: (email) {
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(fontSize: 18),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
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
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
