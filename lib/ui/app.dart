import 'package:flutter/material.dart';
import 'package:qr_manager_application/ui/auth/loginPage.dart';
import 'package:qr_manager_application/ui/auth/registerPage.dart';
import 'package:qr_manager_application/ui/auth/welcome.dart';
import 'package:get/get.dart';
import 'package:qr_manager_application/ui/pages/content/content-list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      title: 'WhatsApp',
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/content/list': (context) => ContentListPage(),
      },
    );
  }
}
