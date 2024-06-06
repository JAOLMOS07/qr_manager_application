import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/services/auth_service.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatelessWidget {
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
                LoginForm(), // Usamos directamente el formulario de inicio de sesión
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
            'INICIAR SESIÓN',
            textAlign: TextAlign.center, // Centra el texto horizontalmente
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[300], // Color azul suave
            ),
          ),
          SizedBox(
              height: 30), // Aumento del espaciado entre los campos y el botón
          // Campos de entrada de texto
          TextField(
            controller: _emailController,
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
          SizedBox(
              height: 60), // Aumento del espaciado entre los campos y el botón
          // Botones
          ElevatedButton(
            onPressed: () async {
              User? user = await authService.LogIn(
                  _emailController.text, _passwordController.text);

              if (user != null) {
                Get.toNamed('/content/list');
              } else {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Oops...',
                  text: 'Creenciales inválidas',
                  confirmBtnText: 'Ok',
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            ),
            child: Text(
              'Login',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(fontSize: 14),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/register');
                },
                child: Text(
                  "Sign up",
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
