import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/services/auth_service.dart';

class ConfigUserPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  ConfigUserPage({Key? key}) : super(key: key);

  void _signOut() async {
    await _authService.signOut();
    Get.offAllNamed(
        '/login'); // Redirige al usuario a la página de inicio de sesión después de cerrar sesión
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _signOut,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Color de fondo rojo
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
