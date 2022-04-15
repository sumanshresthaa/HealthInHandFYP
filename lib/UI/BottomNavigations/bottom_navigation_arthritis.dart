import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../Chatroom/go_to_chat.dart';
import '../Extracted Widgets/showdialog.dart';
import '../Screens/Arthritis Screens/athritis_home.dart';
import '../Screens/BookAppointment/choose_appointment.dart';
import '../Settings/settings.dart';


class BottomNavigationArthritis extends StatefulWidget {
  @override
  _BottomNavigationArthritisState createState() => _BottomNavigationArthritisState();
}

class _BottomNavigationArthritisState extends State<BottomNavigationArthritis> {
  int _currentIndex = 0;

  final _children = [
    HivHome(),
    ChooseAppointment(),
    GoToChat(),
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
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _children[_currentIndex],
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex,
            /*backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            fixedColor: Color(0xFF5686D8),*/
            unselectedItemColor: Colors.grey.shade700,
            items: [
              SalomonBottomBarItem(
                icon: ImageIcon(
                  AssetImage('assets/homeicon.png'),
                  size: 22,
                ),
                title: Text("Home"),
                selectedColor: Color(0xff3FA5DF),
              ),
              SalomonBottomBarItem(
                icon: ImageIcon(
                  AssetImage('assets/appointmenticon.png'),
                  size: 22,
                ),
                title: Text("Appointment"),
                selectedColor: Colors.pink,
              ),
              SalomonBottomBarItem(
                icon: ImageIcon(
                  AssetImage('assets/messageicon.png'),
                  size: 22,
                ),
                title: Text("Messages"),
                selectedColor: Colors.orange,
              ),
              SalomonBottomBarItem(
                icon: ImageIcon(
                  AssetImage('assets/settingicon.png'),
                  size: 22,
                ),
                title: Text("Settings"),
                selectedColor: Colors.teal,
              ),
            ],
            onTap: _onChanged,
            
          ),
        ),
      ),
    );
  }
}
