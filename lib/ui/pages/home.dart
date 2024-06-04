import 'package:flutter/material.dart';
import 'package:qr_manager_application/ui/pages/content/content-list.dart';
import 'package:qr_manager_application/ui/pages/qrcode/qrcode-list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ContentListPage(),
    LinkListPage(),
    ContentListPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _buildNavigationBarItem(
              Icons.list, "Contenidos", _selectedIndex == 0),
          _buildNavigationBarItem(
              Icons.qr_code_2_rounded, "Qr's", _selectedIndex == 1),
          _buildNavigationBarItem(Icons.person_2, "User", _selectedIndex == 2)
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 3,
        backgroundColor: Colors.white,
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      IconData icon, String txtlabel, bool isActive) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color:
              isActive ? const Color.fromARGB(255, 15, 34, 158) : Colors.grey,
        ),
        label: txtlabel);
  }
}
