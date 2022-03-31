import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Models/get_details_of_tb.dart';
import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../Chatroom/chat_room.dart';
import '../../Extracted Widgets/buttons.dart';
import '../../Extracted Widgets/homecontents.dart';
import '../../Extracted Widgets/snackbar.dart';
import '../../LoginPermission/loginpermission.dart';
import '../../ScrollableAppBar/backappbar.dart';
import 'tb_content.dart';
import 'package:provider/provider.dart';

String? finalEmail;

class AboutTBAppBar extends StatefulWidget {
  @override
  State<AboutTBAppBar> createState() => _AboutTBAppBarState();
}

class _AboutTBAppBarState extends State<AboutTBAppBar> {
  late bool englishLanguage = context.watch<DataProvider>().data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: ScrollAppBarNoLeftArrow(TBHome(), englishLanguage ? 'Home' : 'होम'),
    );
  }
}

class TBHome extends StatefulWidget {
  @override
  _TBHomeState createState() => _TBHomeState();
}

class _TBHomeState extends State<TBHome> {
  ConnectivityResult result = ConnectivityResult.none;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var name = sharedPreferences.getString('cpName');
    context.read<DataProvider>().token(token);
    context.read<DataProvider>().createPostName(name);
    setState(() async {
      finalEmail = token;
      result = await Connectivity().checkConnectivity();
      finalEmail == null
          ? Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginPermission();
            }))
          : result == ConnectivityResult.mobile ||
                  result == ConnectivityResult.wifi
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

  Future<DetailsOfTB>? _tbHome;

  Future<DetailsOfTB> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("tb_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfTB.fromJson(jsonMap);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tbHome = getApiData();
  }

  var imagesTB = [
    'assets/about_tb.png',
    'assets/tb_privileges.png',
    'assets/faq.png',
  ];

  @override
  Widget build(BuildContext context) {
    if (_tbHome == null) {
      return Scaffold(
        backgroundColor: Color(0xffF3F7FF),
        body: Text('loading'),
      );
    } else
      return Scaffold(
        backgroundColor: Color(0xffF3F7FF),
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              FutureBuilder<DetailsOfTB>(
                  future: _tbHome,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        color: Colors.transparent,
                        height: 800,
                        child: Shimmer.fromColors(
                          direction: ShimmerDirection.ttb,
                          period: const Duration(milliseconds: 1600),
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
                        padding: const EdgeInsets.only(top: 22.0, bottom: 0.0),
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    snapshot.data!.data!.tbDetails!.length - 1,
                                itemBuilder: (BuildContext context, int index) {
                                  var textContent =
                                      snapshot.data!.data!.tbDetails![index];
                                  return HomeContents(
                                      text: context.read<DataProvider>().data
                                          ? textContent?.name
                                          : textContent?.nameNe,
                                      image: imagesTB[index],
                                      page: AboutTBPage(
                                        indexId: index,
                                        label: context.read<DataProvider>().data
                                            ? textContent?.name
                                            : textContent?.nameNe,
                                      ));
                                }),
                            Padding(
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
                                          var textContent = snapshot
                                              .data!.data!.tbDetails![snapshot
                                                  .data!
                                                  .data!
                                                  .tbDetails!
                                                  .length -
                                              1];
                                          return HomeContentsFAQ(
                                              text: context
                                                      .watch<DataProvider>()
                                                      .data
                                                  ? textContent?.name
                                                  : textContent?.nameNe,
                                              image: imagesTB[snapshot.data!
                                                      .data!.tbDetails!.length -
                                                  1],
                                              page: AboutTBPage(
                                                indexId: index = 2,
                                                label: context
                                                        .watch<DataProvider>()
                                                        .data
                                                    ? textContent?.name
                                                    : textContent?.nameNe,
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
                            ),
                          ],
                        ),
                      );
                  }),
            ],
          ),
        ),
      );
  }
}
