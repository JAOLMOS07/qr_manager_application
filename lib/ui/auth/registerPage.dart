import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_manager_application/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondo1.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/qrmanager2W.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 0), // Separación entre el logo y el formulario
                RegisterForm(), // Usamos directamente el formulario de registro
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final AuthService authService = AuthService();
  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Texto de bienvenida
          Text(
            'REGISTRATE',
            textAlign: TextAlign.center, // Centra el texto horizontalmente
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[300], // Color azul suave
            ),
          ),
          SizedBox(
              height: 5), // Aumento del espaciado entre los campos y el botón
          // Campos de entrada de texto
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Name',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Username',
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
            ),
            obscureText: true,
          ),
          SizedBox(height: 20),
          TextField(
            controller: _repeatPasswordController,
            decoration: InputDecoration(
              hintText: 'Repeat Password',
            ),
            obscureText: true,
          ),
          SizedBox(
              height: 40), // Aumento del espaciado entre los campos y el botón
          // Botones
          ElevatedButton(
            onPressed: () async {
              UserCredential? user = await authService.SingUp(
                  _nameController.text,
                  _usernameController.text,
                  _passwordController.text);
              if (user != null) {
                Get.toNamed('/content/list');
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            ),
            child: Text(
              'Sign up',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Do you already have an account?  ",
                style: TextStyle(fontSize: 14),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/login');
                },
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue, // Color del texto "Sign up"
                    decoration: TextDecoration
                        .underline, // Añade una línea debajo del texto
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
