import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FirebaseChat/FirebaseModel/helperfunction.dart';
import 'ViewModel/changenotifier.dart';
import 'firstloadingscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HelperFunctions.init();
  await Firebase.initializeApp();

  runApp(HealthInHand());
}

class HealthInHand extends StatefulWidget {
  @override
  State<HealthInHand> createState() => _HealthInHandState();
}

class _HealthInHandState extends State<HealthInHand> {
  String? choosePreference;
  String? chooseLanguage;
  bool valueOfLanguage = true;
  bool preference = true;
  bool whichPreference = true;
  bool language = true;

  getPreferenceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    choosePreference = prefs.getString('choosePreference')!;
    //preference = false;
    if (choosePreference == 'hiv') {
      setState(() {
        whichPreference = false;
        language = false;
      });
    } else if (choosePreference == 'tuberculosis') {
      setState(() {
        //preference = false;
        language = false;
      });
    }
  }

  getLanguageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    chooseLanguage = prefs.getString('languageData')!;
    print(chooseLanguage);
    setState(() {
      //preference = false;
      language = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.teal[900],
        systemNavigationBarColor: Colors.black,

        // statusBarBrightness: Brightness.light,
      ),
    );
/*    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);*/

    return ChangeNotifierProvider<DataProvider>(
      create: (context) => DataProvider(),
      child: FirstLoadingScreen(
          language: language,
          preference: preference,
          whichPreference: whichPreference),
    );
  }
}
