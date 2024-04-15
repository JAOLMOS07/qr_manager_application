import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                SizedBox(
                  height: 0,
                ), // Separación entre el logo y el formulario
                LoginForm(), // Usamos directamente el formulario de inicio de sesión
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key});

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
            decoration: InputDecoration(
              hintText: 'Name',
            ),
          ),

          TextField(
            decoration: InputDecoration(
              hintText: 'Username',
            ),
            obscureText: true,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Password',
            ),
          ),

          TextField(
            decoration: InputDecoration(
              hintText: 'Repeat Password',
            ),
            obscureText: true,
          ),
          SizedBox(
              height: 40), // Aumento del espaciado entre los campos y el botón
          // Botones
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/welcome');
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            ),
            child: Text(
              'Sing up',
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
                    color: Colors.blue, // Color del texto "Sing up"
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
