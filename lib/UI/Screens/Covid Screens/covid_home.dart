import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Models/get_details_of_covid.dart';
import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../Chatroom/chat_room.dart';
import '../../Extracted Widgets/buttons.dart';
import '../../Extracted Widgets/homecontents.dart';
import '../../Extracted Widgets/snackbar.dart';
import '../../LoginPermission/loginpermission.dart';
import '../common_screen_part.dart';
import 'covid_content.dart';

String? finalEmail;

/*class AboutCovidAppBar extends StatefulWidget {
  @override
  State<AboutCovidAppBar> createState() => _AboutCovidAppBarState();
}

class _AboutCovidAppBarState extends State<AboutCovidAppBar> {
  late bool englishLanguage = context.watch<DataProvider>().data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: ScrollAppBarNoLeftArrow(
          CovidHome(), englishLanguage ? 'Home' : 'होम'),
    );
  }
}*/

class CovidHome extends StatefulWidget {
  @override
  _CovidHomeState createState() => _CovidHomeState();
}

class _CovidHomeState extends State<CovidHome> {
  late bool englishLanguage = context.watch<DataProvider>().data;
  ConnectivityResult result = ConnectivityResult.none;

  var covidSpecialities = [
    'Covid-19',
    'Asthma ',
    'Cough',
    'Bronchitis',
    'Chest Pain',
  ];
  var specialityIcon = [
    'assets/arthritisicon.jpg',
    'assets/jointicon.png',
    'assets/muscles.png',
    'assets/boneicon.png',
    'assets/muscleicon.png',

  ];

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var name = sharedPreferences.getString('cpName');
    result = await Connectivity().checkConnectivity();
    context.read<DataProvider>().token(token);
    context.read<DataProvider>().createPostName(name);
    setState(() {
      finalEmail = token;
      finalEmail == null
          ? Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginPermission();
            }))
          : (result == ConnectivityResult.mobile ||
                  result == ConnectivityResult.wifi)
              ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChatRoom();
                }))
              : showDialog(
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
                                      return LoginPermission();
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

  Future<DetailsOfCovid>? _covidHome;

  Future<DetailsOfCovid> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("covid_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfCovid.fromJson(jsonMap);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _covidHome = getApiData();
  }

  var imagesHiv = [
    'assets/about_covid.png',
    'assets/covid_living.png',
    'assets/covid_rights.png',
    'assets/covid_faq.png',
  ];

  @override
  Widget build(BuildContext context) {
    if (_covidHome == null) {
      return Scaffold(
        backgroundColor: Color(0xffF3F7FF),
        body: Text('loading'),
      );
    } else
      return Scaffold(
        backgroundColor: Color(0xffF3F7FF),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              HomeDesignAppBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      HomeDesign(imageURL: 'assets/covidhomebook.png', specialities: covidSpecialities, specialityIcon: specialityIcon,type: 'covid'),
                      FutureBuilder<DetailsOfCovid>(
                          future: _covidHome,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                height: 800,
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
                                padding: const EdgeInsets.only(top: 22.0, bottom: 22.0),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                            snapshot.data!.data!.covidDetails!.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          var textContent =
                                              snapshot.data!.data!.covidDetails![index];
                                          return HomeContents(
                                              text: englishLanguage
                                                  ? textContent.name
                                                  : textContent.nameNe,
                                              image: imagesHiv[index],
                                              page: AboutCovidPage(
                                                indexId: index,
                                                label:
                                                englishLanguage
                                                        ? textContent.name
                                                        : textContent.nameNe,
                                              ));
                                        }),
                                   /* Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemCount: 1,
                                                itemBuilder:
                                                    (BuildContext context, int index) {
                                                  var textContent = snapshot.data!.data!
                                                      .covidDetails![snapshot.data!
                                                          .data!.covidDetails!.length -
                                                      1];
                                                  return HomeContentsFAQ(
                                                      text: context
                                                              .watch<DataProvider>()
                                                              .data
                                                          ? textContent!.name
                                                          : textContent!.nameNe,
                                                      image: imagesHiv[snapshot
                                                              .data!
                                                              .data!
                                                              .covidDetails!
                                                              .length -
                                                          1],
                                                      page: AboutCovidPage(
                                                        indexId: index,
                                                        label: context
                                                                .watch<DataProvider>()
                                                                .data
                                                            ? textContent.name
                                                            : textContent.nameNe,
                                                      ));
                                                }),
                                          ),
                                          SizedBox(
                                            width: 16.0,
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                getValidationData();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(8)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          Colors.grey.withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: Offset(0,
                                                          0.5), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 148,
                                                      width: double.infinity,
                                                      child: Image(
                                                        image: AssetImage(
                                                          'assets/grievance.png',
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 34,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: Center(
                                                          child: Text(
                                                            'Your Grievance',
                                                            style: kStyleHome,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),*/
                                  ],
                                ),
                              );
                          }),
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
