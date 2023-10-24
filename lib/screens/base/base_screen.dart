import 'package:flutter/material.dart';
import 'package:loja_virtual/commom/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  BaseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            LoginScreen(),
            Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home'),
                ),
                body:
                    Container(color: const Color.fromARGB(255, 158, 123, 120))),
            Container(color: Colors.red),
            Container(color: Colors.green),
            Container(color: Colors.blue),
            Container(color: Colors.yellow),
            Container(color: Colors.purple),
            Container(color: Colors.pink),
            Container(color: Colors.orange),
            Container(color: Colors.teal),
            Container(color: Colors.brown),
            Container(color: Colors.cyan),
            Container(color: Colors.indigo),
          ]),
    );
  }
}
