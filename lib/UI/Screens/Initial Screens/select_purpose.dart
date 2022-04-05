import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../BottomNavigations/bottom_navigation_covid.dart';
import '../../BottomNavigations/bottom_navigation_hiv.dart';
import '../../BottomNavigations/bottom_navigation_tb.dart';
import '../../Extracted Widgets/buttons.dart';

class SelectPurpose extends StatefulWidget {
  @override
  _SelectPurposeState createState() => _SelectPurposeState();
}

class _SelectPurposeState extends State<SelectPurpose> {
// TODO : initialize the snackbar and cache all the data in the offline database

  late bool englishLanguage = context.watch<DataProvider>().data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //  sharedPreferenceLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffffff),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 18,
              top: 16,
              bottom: 16,
              right: 14,
            ),
            child: Image.asset(
              'assets/arrow.png',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/profile.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 8.0),
                      child: Text(
                        englishLanguage ? 'Welcome, User' : 'स्वागत छ',
                        style: kStyleTime,
                      ),
                    ),
                    Text(
                      englishLanguage
                          ? 'Let\'s start with what you want\nto use our app for'
                          : 'हजुरले हाम्रो एप के कारण को लागि \nप्रयोग गर्न चाहनुहुन्छ ? ',
                      style: kStyleCheckedIn,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 128,
                    ),
                    Text(
                      englishLanguage ? 'Select Purpose' : 'रोग चयन गर्नुहोस्',
                      style: kStyleSelect,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: LangButton(
                        () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('choosePreference', 'hiv');
                          context.read<DataProvider>().purpose('hiv');
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              /*            settings: RouteSettings(name: '/1'),*/
                              builder: (context) => BottomNavigationHiv(),
                            ),
                            ModalRoute.withName('/'),
                          );
                        },
                        englishLanguage ? 'Athritis' : 'एचआईभी',
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: LangButton(
                        () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('choosePreference', 'covid');
                          context.read<DataProvider>().purpose('covid');

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              /*            settings: RouteSettings(name: '/1'),*/
                              builder: (context) => BottomNavigationCovid(),
                            ),
                            ModalRoute.withName('/'),
                          );
                        },
                        englishLanguage ? 'COVID-19' : 'कोरोना भाईरस',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: Text(
                        englishLanguage
                            ? 'You can change the purpose later\nfrom the settings menu.'
                            : ' हजुरले सेटिङ्बाट बिषय \n परिवर्तन गर्न सक्नुहुन्छ। ',
                        style: kStyleSelect.copyWith(
                            fontSize: 12, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
