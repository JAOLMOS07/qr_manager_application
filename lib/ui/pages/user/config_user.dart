import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/services/auth_service.dart';
import 'package:quickalert/quickalert.dart';

class ConfigUserPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  ConfigUserPage({Key? key}) : super(key: key);

  _signOut() async {
    print("salir");
    await _authService.signOut();
    Get.offAllNamed(
        '/login'); // Redirige al usuario a la página de inicio de sesión después de cerrar sesión
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _authService.getCurrentUser(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.hasData) {
            User? user = snapshot.data;
            String displayName = user?.displayName ?? 'Usuario';
            String initial = displayName.isNotEmpty ? displayName[0] : 'U';
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Text(
                      initial,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    displayName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          title: "¿Estás seguro?",
                          text: '¿Quieres cerrar la sesión?',
                          confirmBtnText: 'Si',
                          cancelBtnText: 'No',
                          showConfirmBtn: true,
                          showCancelBtn: true,
                          confirmBtnColor: Colors.green,
                          onConfirmBtnTap: () async {
                            await _signOut();
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Color de fondo rojo
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
                ],
              ),
            );
          } else {
            return Center(child: Text("No user logged in"));
          }
        },
      ),
    );
  }
}
