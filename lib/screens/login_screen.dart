import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'signup_screen.dart'; // Importa la pantalla de registro
import 'home_screen.dart'; // Importa la pantalla a la que quieres navegar después del login exitoso

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final isValid = await ApiService.comparePassword(email, password);
    if (isValid) {
      bool isAdmin = await ApiService.isAdmin(email);
      // Navegar a la siguiente pantalla si el login es exitoso
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(isAdmin: isAdmin)),
      );
    } else {
      setState(() {
        _message = 'Invalid email or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            Text(_message),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navegar a la pantalla de registro cuando se hace clic en el botón de Sign Up
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

