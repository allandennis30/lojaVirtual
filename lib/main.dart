import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/base/base_screen.dart';

void main() {
  runApp(LojaVirtual());
}

class LojaVirtual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(elevation: 0),
          primaryColor: Colors.indigo,
          scaffoldBackgroundColor: Colors.indigo),
      home: BaseScreen(),
    );
  }
}
