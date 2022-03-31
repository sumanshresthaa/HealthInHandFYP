import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Network/api_links.dart';
import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../Extracted Widgets/buttons.dart';
import '../../Extracted Widgets/snackbar.dart';

class SelectLanguage extends StatefulWidget {
  final page;
  final showTheDialog;

  SelectLanguage({@required this.page, this.showTheDialog});

  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  bool lang = true; //Making language english at first
  var hivHome;
  var obtainedMethod;
  var internetButNoInternet;
  var languageSharedPreference;

  //bool? showTheDialog = true;
  ConnectivityResult result = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    sharedPreferenceLanguage();
    saveDialogValue().whenComplete(() {
      //after checking saveDialogValue which checks obMethod and interntButNoInternet. It will check if it is null or not
      if (obtainedMethod == null || internetButNoInternet == null) {
        downloadContent();
        /* retrySnackBar(context);*/
      }
    });
  }

  //Function for whether to put back button or not in the select language page
  sharedPreferenceLanguage() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedLanguage = sharedPreferences.getBool('languageData');
    if (obtainedLanguage != null) {
      context.read<DataProvider>().changeString(obtainedLanguage);
    }
    setState(() {
      languageSharedPreference = obtainedLanguage;
    });
  }

  //Snackbar which shows in case of failure to download content
  void retrySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Failed to download the content',
        style: kStyleCheckedIn.copyWith(fontSize: 14, color: Colors.white),
      ),
      action: SnackBarAction(
          label: "Retry",
          textColor: Colors.blue,
          onPressed: () {
            downloadContent();
          }),
      duration: Duration(days: 1),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //calls the snackbarFunction which will call the download class
  Future downloadContent() async {
    if (snackBarFunction() == true) { //if download is complete it wont show anything here
      print("done");
    } else {
      _showDialog();//while the download is happening it will show this and any error handling is done in the method
    }
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      sharedPreferences.setString('show', 'download'); //When this downloadContent is called it sets the show
    }
  }

  //Tries to find if the show and internetbutnointernet is null or not
  Future saveDialogValue() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainMethod = sharedPreferences.getString('show');
    var fullInternetCheck =
        sharedPreferences.getString('internetButNoInternet');
    setState(() {
      obtainedMethod = obtainMethod;
      internetButNoInternet = fullInternetCheck;
    });
  }

  //The main showdialog function which will work based on internte
  _showDialog() async {
    result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(
            Duration(seconds: 15), //If there are server error or internet error till 15 sec it will ask to retry
            () {
              Navigator.of(context).pop(true);
              print("failed");
              retrySnackBar(context);
            },
          );
          return AlertDialog(
            title: Text('Loading...'),
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text('The app is loading.'),
                )
              ],
            ),
          );
        },
      );
    } else {
      print("Failed");
      showDialog(
        barrierColor: Colors.blueAccent.withOpacity(0.3),
        barrierDismissible: false,
        context: context,
        builder: (_) => Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            FittedBox(
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100]),
                padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/nowifi.png',
                      width: 91,
                    ),
                    Text(
                      "Connection Problem",
                      style: kStyleHContent.copyWith(
                          fontSize: 20, decoration: TextDecoration.none),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "We’re having difficulty connecting to\nthe sever. Check your connection or try\nagain later.",
                      textAlign: TextAlign.center,
                      style: kStyleSelect.copyWith(
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(height: 28),
                    LoginButton(
                      'Retry',
                      () async {
                        result = await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.mobile ||
                            result == ConnectivityResult.wifi) {
                          Navigator.of(context, rootNavigator: true).pop();
                          downloadContent();
                        } else {
                          showSnackBar(
                            context,
                            "Attention",
                            Colors.blue,
                            Icons.info,
                            "You must be connected to the internet.",
                          );
                        }
                      },
                    ),
                    SizedBox(height: 14),
                    WhiteButton(
                      'Exit',
                      () {
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  //Calls the api_links.dart ApiData class and downloads data
  Future<bool> snackBarFunction() async {
    ApiData apiData = ApiData();
    await apiData.downloadData().whenComplete(() async {
    });
    showSnackBar(
      context,
      "Success",
      Colors.teal,
      Icons.check_circle,
      "Content Downloaded Successfully!",
    ); //When the download completes this will be shown
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    sharedPreferences.setString(
        'internetButNoInternet', 'internetButNoInternet');//When the download completes internetButNOInternet is no longer null
    print("Download Success");
    Navigator.pop(context);
    return true;
  }

//Snackbar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: languageSharedPreference != null
          ? AppBar(
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
            )
          : AppBar(
              backgroundColor: Color(0xfffffff),
              elevation: 0,
            ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*      TextButton(
                  onPressed: () {
                    retrySnackBar(context);
                  },
                  child: Text("Hi"),
                ),*/
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
                        lang ? 'Welcome, User' : 'स्वागत छ',
                        style: kStyleTime,
                      ),
                    ),
                    Text(
                      lang
                          ? 'Which language do you prefer\nfor this app?'
                          : 'तपाईं कुन भाषा प्रयोग गर्न चाहनु हुन्छ?',
                      style: kStyleCheckedIn,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 128,
                    ),
                    Text(
                      'Select Language\nभाषा छनोट गर्नुहोस्',
                      style: kStyleSelect,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                      child: LangButton(
                        () async {
                          setState(() {
                            lang = !lang;
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('languageData', true);

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              /*            settings: RouteSettings(name: '/1'),*/
                              builder: (context) => widget.page,
                            ),
                            ModalRoute.withName('/'),
                          );

                          //Provider.of<Data>(context).changeString(true);
                          context.read<DataProvider>().changeString(true);
                        },
                        'English',
                      ),
                    ),
                    LangButton(() async {
                      setState(() {
                        lang = !lang;
                      });

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('languageData', false);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          /*            settings: RouteSettings(name: '/1'),*/
                          builder: (context) => widget.page,
                        ),
                        ModalRoute.withName('/'),
                      );

                      context.read<DataProvider>().changeString(false);
                    }, 'नेपाली'),
                    Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: Text(
                        lang
                            ? 'You can change the language later\nfrom the settings menu.'
                            : ' हजुरले सेटिङ्बाट भाषा \n परिवर्तन गर्न सक्नुहुन्छ।',
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
/*
FutureBuilder<bool>(
future: showLoginPage(),
builder: (buildContext, snapshot) {
if(snapshot.hasData) {
if(snapshot.data){
// Return your login here
return Container(color: Colors.blue);
}

// Return your home here
return Container(color: Colors.red);
} else {

// Return loading screen while reading preferences
return Center(child: CircularProgressIndicator());
}
},
)*/
