import 'package:flutter/material.dart';
import 'package:qr_manager_application/ui/auth/login_page.dart';
import 'package:qr_manager_application/ui/auth/register_page.dart';
import 'package:qr_manager_application/ui/auth/welcome.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/ui/pages/content/edit_content.dart';
import 'package:qr_manager_application/ui/pages/home.dart';
import 'package:qr_manager_application/ui/pages/content/create_content.dart';
import 'package:qr_manager_application/ui/pages/qrcode/create_codeqr.dart';
import 'package:qr_manager_application/ui/pages/qrcode/qrcode_asign_content.dart';

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
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/content/list': (context) => const HomePage(),
        '/content/create': (context) => const AddContentPage(),
        '/content/edit': (context) => const EditContentPage(),
        '/link/create': (context) => const CreateQrCodePage(),
        '/link/assign': (context) => const ViewQrCodePage(),
      },
    );
  }
}
