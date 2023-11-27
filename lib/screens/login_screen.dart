import 'package:flutter/material.dart';
import 'package:galeria_reales/providers/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final String username = _usernameController.text;
                final String password = _passwordController.text;

                // Simulación de validación de credenciales
                if (username.isNotEmpty && password.isNotEmpty) {
                  // Simulación de inicio de sesión exitoso
                  userManager.saveUser('user_id', username);

                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // Muestra un mensaje de error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid username or password'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}