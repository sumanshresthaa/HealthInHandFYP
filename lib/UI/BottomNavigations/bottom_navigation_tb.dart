import 'package:flutter/material.dart';
import '../Extracted Widgets/showdialog.dart';
import '../Screens/TB Screens/Medication/MedicationList.dart';
import '../Screens/TB Screens/tb_home.dart';
import '../Settings/settings.dart';

class BottomNavigationTB extends StatefulWidget {
  BottomNavigationTB();
  @override
  _BottomNavigationTBState createState() => _BottomNavigationTBState();
}

class _BottomNavigationTBState extends State<BottomNavigationTB> {
  int _currentIndex = 0;
  final _children = [
    AboutTBAppBar(),
    MedicationsPage(),
    Settings(),
  ];

  void _onChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          await showBackDialog(context);
        } else if (_currentIndex != 0) {
          _onChanged(0);
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          fixedColor: Color(0xFF5686D8),
          unselectedItemColor: Colors.grey.shade700,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/nav_home.png'),
                size: 24,
              ),
              label: '',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  'assets/nav_med.png',
                ),
                size: 24,
              ),
              label: '',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/nav_setting.png'),
                size: 24,
              ),
              label: '',
              backgroundColor: Colors.white,
            ),
          ],
          onTap: _onChanged,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
