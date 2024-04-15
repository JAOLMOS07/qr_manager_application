import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
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
                  'assets/qrmanagerW.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                    height:
                        200), // Ajusta la separación entre el logo y el botón
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                    height:
                        20), // Ajusta la separación entre el botón y el texto
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/register');
                      },
                      child: Text(
                        "Sing up",
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
          ),
        ],
      ),
    );
  }
}
