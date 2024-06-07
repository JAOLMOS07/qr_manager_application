import 'package:flutter/material.dart';
import 'package:qr_manager_application/ui/auth/loginPage.dart';
import 'package:qr_manager_application/ui/auth/registerPage.dart';
import 'package:qr_manager_application/ui/auth/welcome.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/ui/pages/content/edit_content.dart';
import 'package:qr_manager_application/ui/pages/home.dart';
import 'package:qr_manager_application/ui/pages/content/create-content.dart';
import 'package:qr_manager_application/ui/pages/qrcode/create_codeqr.dart';
import 'package:qr_manager_application/ui/pages/qrcode/qrcode-asign-content.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      title: 'QrManager',
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/content/list': (context) => const HomePage(),
        '/content/create': (context) => AddContentPage(),
        '/content/edit': (context) => EditContentPage(),
        '/link/create': (context) => CreateQrCodePage(),
        '/link/assign': (context) => ViewQrCodePage(),
      },
    );
  }
}
