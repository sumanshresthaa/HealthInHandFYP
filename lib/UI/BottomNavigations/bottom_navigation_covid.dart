import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../Extracted Widgets/showdialog.dart';
import '../LoginPermission/loginpermission.dart';
import '../Screens/BookAppointment/appointment.dart';
import '../Screens/Covid Screens/covid_home.dart';
import '../Settings/settings.dart';


//Bottom navigations which sends the value to the home page
class BottomNavigationCovid extends StatefulWidget {
  @override
  _BottomNavigationCovidState createState() => _BottomNavigationCovidState();
}

class _BottomNavigationCovidState extends State<BottomNavigationCovid> {

  int _currentIndex = 0;

  final _children = [
    CovidHome(),
    BookAppointment(),
    LoginPermission(),
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
                selectedColor: Color(0xff2B7853),
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
                  AssetImage('assets/profileicon.png'),
                  size: 22,
                ),
                title: Text("Profile"),
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
