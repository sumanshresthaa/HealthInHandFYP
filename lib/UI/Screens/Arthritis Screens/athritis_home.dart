import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Screens/BookAppointment/appointment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../FirebaseChat/FirebaseModel/constant_names.dart';
import '../../../FirebaseChat/FirebaseModel/helperfunction.dart';
import '../../../Models/get_details_of_Arthritis.dart';
import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../Chatroom/chat_room.dart';
import '../../Extracted Widgets/buttons.dart';
import '../../Extracted Widgets/homecontents.dart';
import '../../Extracted Widgets/snackbar.dart';
import '../../LoginPermission/loginpermission.dart';
import '../../ScrollableAppBar/backappbar.dart';
import '../common_screen_part.dart';
import 'hiv_content.dart';


class AboutHivAppBar extends StatefulWidget {
  @override
  State<AboutHivAppBar> createState() => _AboutHivAppBarState();
}

class _AboutHivAppBarState extends State<AboutHivAppBar> {
  late bool englishLanguage = context
      .watch<DataProvider>()
      .data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body:
      ScrollAppBarNoLeftArrow(HivHome(), englishLanguage ? 'Home' : 'होम'),
    );
  }
}




class HivHome extends StatefulWidget {
  @override
  _HivHomeState createState() => _HivHomeState();
}

class _HivHomeState extends State<HivHome> {
  int activeIndex = 0;

  ConnectivityResult result = ConnectivityResult.none;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Future<DetailsOfArthritis>? _arthritisHome;

  Future<DetailsOfArthritis> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("arthritis_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfArthritis.fromJson(jsonMap);
  }


  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var name = sharedPreferences.getString('cpName');
    result = await Connectivity().checkConnectivity();
    context.read<DataProvider>().token(token);
    context.read<DataProvider>().createPostName(name);
    setState(() {
      userIsLoggedIn != null
          ? Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ChatRoom();
      }))
          : (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi)
          ? Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginPermission();
      }))
          : showDialog(
        barrierColor: Colors.blueAccent.withOpacity(0.3),
        barrierDismissible: false,
        context: context,
        builder: (_) =>
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: <Widget>[
                FittedBox(
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 40,
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
                              fontSize: 20,
                              decoration: TextDecoration.none),
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
                            result =
                            await Connectivity().checkConnectivity();
                            if (result == ConnectivityResult.mobile ||
                                result == ConnectivityResult.wifi) {
                              Navigator.pop(context, result);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return ChatRoom();
                                  }));
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
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
      );
    });
  }

  bool? userIsLoggedIn;

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      userIsLoggedIn = value;
      print("hey");
      print(value);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getLoggedInState();
    super.initState();
    _arthritisHome = getApiData();
  }


  var imagesHiv = [
    'assets/about_hiv.png',
    'assets/imagetwo.png',
  ];



  var arthritisSpecialities = [
  'Arthritis',
     'Joints',
    'Muscles',
    'Bones',
    'Back Pain',
  ];


  var specialityIcon = [
    'assets/arthritisicon.jpg',
    'assets/jointicon.png',
    'assets/muscles.png',
    'assets/boneicon.png',
    'assets/muscleicon.png',

  ];


  @override
  Widget build(BuildContext context) {
    if (_arthritisHome == null) {
      return Scaffold(
        backgroundColor: Color(0xffF3F7FF),
        body: Text('loading'),
      );
    } else
      return Scaffold(
          backgroundColor: Color(0xffF3F7FF),
          key: scaffoldKey,
          drawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),

          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  HomeDesignAppBar(scaffoldKey: scaffoldKey),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          HomeDesign(imageURL: 'assets/arthritishomebook.png', specialities: arthritisSpecialities, type: 'arthritis', specialityIcon: specialityIcon),


                          FutureBuilder<DetailsOfArthritis>(
                              future: _arthritisHome,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container(
                                    height: 800,
                                    //Loading like Facebook
                                    child: Shimmer.fromColors(
                                      direction: ShimmerDirection.ttb,
                                      period: const Duration(milliseconds: 8000),
                                      child: ListView.builder(
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.all(16),
                                              height: 160,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                color: Colors.black,
                                              ),
                                            );
                                          }),
                                      baseColor: Color(0xFFE5E4E2),
                                      highlightColor: Color(0xFFD6D6D6),
                                    ),
                                  );
                                } else
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, bottom: 22.0),
                                      child: Column(
                                          children: [
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                snapshot.data!.data!.arthritisDetails!.length,
                                                itemBuilder: (BuildContext context,
                                                    int index) {
                                                  var textContent =
                                                  snapshot.data!.data!
                                                      .arthritisDetails![index];
                                                  return HomeContents(
                                                      text: context
                                                          .watch<DataProvider>()
                                                          .data
                                                          ? textContent.name
                                                          : textContent.nameNe,
                                                      image: imagesHiv[index],
                                                      page: AboutHivPage(
                                                        indexId: index,
                                                        label:
                                                        context
                                                            .watch<DataProvider>()
                                                            .data
                                                            ? textContent.name
                                                            : textContent.nameNe,
                                                      ));
                                                }),
                                          ]));
                              }),
                        ],
                      ),
                    ),
                  ),


                ],)));
  }}

