import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Login/logout.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Network/NetworkHelper.dart';
import '../../Network/api_links.dart';
import '../../Notification/hiv_notification.dart';
import '../../Notification/tb_notification.dart';
import '../../Textstyle/constraints.dart';
import '../../ViewModel/changenotifier.dart';
import '../BottomNavigations/bottom_navigation_covid.dart';
import '../BottomNavigations/bottom_navigation_hiv.dart';
import '../BottomNavigations/bottom_navigation_tb.dart';
import '../Extracted Widgets/snackbar.dart';
import '../Screens/Hotline Numbers/hotline_numbers.dart';
import '../Screens/Initial Screens/select_language.dart';
import '../Screens/Initial Screens/select_purpose.dart';
import '../ScrollableAppBar/backappbar.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool englishLanguage = context.watch<DataProvider>().data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: ScrollAppBarNoLeftArrow(
          SettingsContent(), englishLanguage ? "Settings" : 'सेटिङ्'),
    );
  }
}

class SettingsContent extends StatefulWidget {
  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  late bool englishLanguage = context.watch<DataProvider>().data;
  late var selectedPurpose = context.watch<DataProvider>().purposes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: [
          Column(
            children: [
              SettingsList(
                  englishLanguage
                      ? 'Change Language'
                      : 'भाषा परिवर्तन गर्नुहोस् ',
                  Icons.language_outlined, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SelectLanguage(page: selectedPurpose == "hiv" ?BottomNavigationHiv() : selectedPurpose == "tuberculosis" ?BottomNavigationTB() : BottomNavigationCovid());
                }));
              }),
              SettingsList(
                  englishLanguage
                      ? 'Change Purpose'
                      : 'बिषय परिवर्तन गर्नुहोस्',
                  Icons.settings_outlined, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SelectPurpose();
                }));
              }),
              selectedPurpose != "covid" ? SettingsList(
                  englishLanguage
                      ? 'Change Medication Reminder'
                      : 'औषधी अनुस्मारक परिवर्तन गर्नुहोस्',
                  Icons.notifications_none_outlined, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return selectedPurpose == "hiv" ? HivNotification() : TBNotification();
                }));
              }): Container(),
              SettingsList(
                englishLanguage ? 'Update Content' : 'जानकारी अपडेट गर्नुहोस्',
                Icons.refresh_outlined,
                    () {
                  if (update() == true) {
                    print("done");
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => AlertDialog(
                          title: Text('Updating Content'),
                          content: Row(
                            children: [
                              CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                  child: Text(
                                      'Please wait while we update the content.'))
                            ],
                          )),
                    );
                  }
                },
              ),
    SettingsList(englishLanguage ? 'Log Out' : 'एपको बारेमा ',
            Icons.logout, () async {
          LogoutDialog().showDialogLogout(context);
         }),
              SettingsList(englishLanguage ? 'About App' : 'एपको बारेमा ',
                  Icons.error_outline, () {
Navigator.push(context, MaterialPageRoute(builder: (context){
 return HotlineNumbersScreen();

}));

                  }),
              SettingsList(englishLanguage ? 'Contributors' : 'योगदनकर्ताहरु ',
                  Icons.group_outlined, () async {


                  }),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> update() async {
    ApiData apiData = ApiData();
    await apiData.updateContent();
    showSnackBar(
      context,
      "Success",
      Colors.teal,
      Icons.check_circle,
      "Content Downloaded Successfully!",
    );
    Navigator.pop(context);
    return true;
  }
}

class SettingsList extends StatelessWidget {
  SettingsList(this.setting, this.icon, this.onPress);

  final String setting;
  final IconData icon;
  final onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue[100]!.withOpacity(0.5),
                blurRadius: 4.0, // soften the shadow
                offset: Offset(
                  2.0, // Move to right 10  horizontally
                  2.0, // Move to bottom 10 Vertically
                ),
              ),
            ]),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  height: 36,
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.teal[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        setting,
                        style: kStyleContent,
                      ),
                    ),
                    Icon(
                      icon,
                      color: Colors.grey[500],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
