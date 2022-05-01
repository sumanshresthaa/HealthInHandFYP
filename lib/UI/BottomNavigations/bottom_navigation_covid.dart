import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../ViewModel/changenotifier.dart';
import '../Chatroom/go_to_chat.dart';
import '../Extracted Widgets/showdialog.dart';
import '../LoginPermission/loginpermission.dart';
import '../Screens/BookAppointment/appointment.dart';
import '../Screens/BookAppointment/choose_appointment.dart';
import '../Screens/Covid Screens/covid_home.dart';
import '../Settings/settings.dart';


//Bottom navigations which sends the value to the home page
class BottomNavigationCovid extends StatefulWidget {
  @override
  _BottomNavigationCovidState createState() => _BottomNavigationCovidState();
}

class _BottomNavigationCovidState extends State<BottomNavigationCovid> {
  late bool englishLanguage = context.watch<DataProvider>().data;

  int _currentIndex = 0;

  final _children = [
    CovidHome(),
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
                  AssetImage('assets/settingicon.png'),
                  size: 22,
                ),
                title: Text(englishLanguage ? "Settings" : "सेटिङ्"),
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
