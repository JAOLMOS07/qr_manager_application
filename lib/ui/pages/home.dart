import 'package:flutter/material.dart';
import 'package:qr_manager_application/ui/pages/user/config_user.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:qr_manager_application/ui/pages/content/content-list.dart';
import 'package:qr_manager_application/ui/pages/qrcode/qrcode-list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ContentListPage(),
    LinkListPage(),
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
            icon: Icon(Icons.list),
            title: Text("Contenidos"),
            selectedColor: Color.fromARGB(255, 10, 29, 171),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.qr_code_2_rounded),
            title: Text("Links"),
            selectedColor: Color.fromARGB(255, 15, 34, 171),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person_2_outlined),
            title: Text("Usuario"),
            selectedColor: Color.fromARGB(255, 10, 29, 171),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            title: Text("Escanner"),
            selectedColor: Color.fromARGB(255, 10, 29, 171),
          ),
        ],
      ),
    );
  }
}
