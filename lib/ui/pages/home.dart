import 'package:flutter/material.dart';
import 'package:qr_manager_application/ui/pages/user/config_user.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:qr_manager_application/ui/pages/content/content_list.dart';
import 'package:qr_manager_application/ui/pages/qrcode/qrcode_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ContentListPage(),
    const LinkListPage(),
    ConfigUserPage(),
    ConfigUserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.list),
            title: const Text("Contenidos"),
            selectedColor: const Color.fromARGB(255, 10, 29, 171),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.qr_code_2_rounded),
            title: const Text("Links"),
            selectedColor: const Color.fromARGB(255, 15, 34, 171),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_2_outlined),
            title: const Text("Usuario"),
            selectedColor: const Color.fromARGB(255, 10, 29, 171),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.qr_code_scanner_outlined),
            title: const Text("Escanner"),
            selectedColor: const Color.fromARGB(255, 10, 29, 171),
          ),
        ],
      ),
    );
  }
}
