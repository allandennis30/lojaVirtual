import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/base/base_screen.dart';
import 'package:loja_virtual/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart'; // Importe o Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicialize o Firebase
  runApp(const LojaVirtual());
}

class LojaVirtual extends StatelessWidget {
  const LojaVirtual({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(elevation: 0),
            primaryColor: Colors.indigo,
            scaffoldBackgroundColor: Colors.indigo),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/base':
              return MaterialPageRoute(
                builder: (_) => BaseScreen(),
              );
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignupScreen());
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
