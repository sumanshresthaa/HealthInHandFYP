import 'package:flutter/material.dart';
import 'package:health_in_hand/FirebaseChat/FirebaseModel/helperfunction.dart';
import 'package:sizer/sizer.dart';
import 'Models/get_email.dart';
import 'UI/BottomNavigations/bottom_navigation_covid.dart';
import 'UI/BottomNavigations/bottom_navigation_arthritis.dart';
import 'UI/Screens/Initial Screens/select_language.dart';
import 'UI/Screens/Initial Screens/select_purpose.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'ViewModel/changenotifier.dart';

class FirstLoadingScreen extends StatefulWidget {
  FirstLoadingScreen({this.language, this.preference, this.whichPreference});
  final language;
  final preference;
  final whichPreference;

  @override
  State<FirstLoadingScreen> createState() => _FirstLoadingScreenState();
}

class _FirstLoadingScreenState extends State<FirstLoadingScreen> {
  var languageSharedPreference;
  var preferenceSharedPreference;
  var token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    token = HelperFunctions.getTokenSharedPreference() ?? 'notoken';

    sharedPreferenceLanguage();
    sharedPreferencePreference();
  }



/*  Future sharedPreferenceLogin() async {
    setState(() {
      context.read<DataProvider>().token(token);
    });
  }*/

  sharedPreferenceLanguage() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedLanguage = sharedPreferences.getBool('languageData');
    if (obtainedLanguage != null) {
      context.read<DataProvider>().changeString(obtainedLanguage);
    }
    setState(() {
      languageSharedPreference = obtainedLanguage;
      context.read<DataProvider>().token(token);
    });
  }

  sharedPreferencePreference() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedPreferences = sharedPreferences.getString('choosePreference');
/*if(obtainedPreferences!= null){
    // context.read<DataProvider>().changeString(
    //     obtainedLanguage);
  }*/

    setState(() {
      preferenceSharedPreference = obtainedPreferences;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (context) => languageSharedPreference == null
                ? SelectLanguage(page: SelectPurpose())
                : (preferenceSharedPreference == null
                    ? SelectPurpose()
                    : (preferenceSharedPreference == 'hiv'
                        ? BottomNavigationArthritis()
                        : preferenceSharedPreference == 'tuberculosis'
                            ? BottomNavigationArthritis()
                            : preferenceSharedPreference == 'covid'
                                ? BottomNavigationCovid()
                                : SelectPurpose())),
            '/3': (context) => BottomNavigationArthritis(),
            '2': (context) => BottomNavigationArthritis(),
            '/abt': (context) => BottomNavigationCovid(),
          },
          theme: Theme.of(context).copyWith(
            appBarTheme: Theme.of(context)
                .appBarTheme
                .copyWith(brightness: Brightness.light),
          ),
          debugShowCheckedModeBanner: false,
          // home: SelectLanguage(page: SelectPurpose()),
          /* language
            ? SelectLanguage(
                page: preference
                    ? SelectPurpose()
                    : (whichPreference
                        ? BottomNavigationTB()
                        : BottomNavigationHiv()),
              )
            : (whichPreference ? BottomNavigationTB() : BottomNavigationHiv()),*/
        );
      },
    );
  }
}
