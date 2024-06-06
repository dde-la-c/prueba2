import 'package:flutter/material.dart';
import '../service/api_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  String _message = '';

  void _guardarUsuario() async {
    final nombre = _nombreController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Validar que todos los campos estén completos
    if (nombre.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        _message = 'Por favor completa todos los campos';
      });
      return;
    }

    // Validar que las contraseñas coincidan
    if (password != confirmPassword) {
      setState(() {
        _message = 'Las contraseñas no coinciden';
      });
      return;
    }

    // Enviar los datos del usuario al servidor para guardar
    final isSuccess = await ApiService.insertarUsuario(nombre, email, password);

    if (isSuccess) {
      setState(() {
        _message = 'Usuario creado exitosamente';
      });
    } else {
      setState(() {
        _message = 'Error al crear el usuario';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarUsuario,
              child: Text('Crear Cuenta'),
            ),
            SizedBox(height: 20),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
