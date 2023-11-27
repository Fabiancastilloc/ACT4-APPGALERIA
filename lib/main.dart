import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:galeria_reales/providers/user_manager.dart';
import 'package:galeria_reales/screens/home_screen.dart';
import 'package:galeria_reales/screens/login_screen.dart';
import 'package:galeria_reales/screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserManager(),
      child: MaterialApp(
        title: 'Galería Reales',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegistrationScreen(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
