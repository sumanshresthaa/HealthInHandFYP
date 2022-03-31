import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
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

String? finalEmail;

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
      print(userIsLoggedIn);
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

  Future<DetailsOfArthritis>? _arthritisHome;

  Future<DetailsOfArthritis> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("arthritis_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfArthritis.fromJson(jsonMap);
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

  var carouselHiv = [
    'assets/hiv_carousel1.png',
    'assets/hiv_carousel2.png',
    'assets/hiv_carousel3.png',
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
                          HomeDesign(imageURL: 'assets/arthritishomebook.png'),
                          FutureBuilder<DetailsOfArthritis>(
                              future: _arthritisHome,
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
                                          var textContent = snapshot
                                              .data!.data!.hivDetails![snapshot
                                                  .data!
                                                  .data!
                                                  .hivDetails!
                                                  .length -
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
                                                      .hivDetails!
                                                      .length -
                                                  1],
                                              page: AboutHivPage(
                                                indexId: index = 3,
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
                                        print('finalEmail$finalEmail');
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
                                                    context
                                                            .watch<
                                                                DataProvider>()
                                                            .data
                                                        ? 'Become a Member'
                                                        : 'तपाइको गुनासो',
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
                            ),*/ /*
                          ],
                        ),
                      );
                  }),*/

/*Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Our Services', style: kStyleCheckedIn.copyWith(fontWeight: FontWeight.w600, color: Color(0xff333333)),),
              ),
              Container(
                color: Color(0xffEBEEF4),
                height: 120.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,

                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                        child: Container(



                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],

                              color: Colors.white,

                              //gradient: LinearGradient(colors: [Color(0xff3A00BF), Color(0xff16A3FF)]),
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),

                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          width: 250.0,


                          child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(image[index]),
                                      radius: 25.0,
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(left:8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(person[index],
                                            textAlign:TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blue.shade100,
                                                borderRadius: BorderRadius.all(Radius.circular(5.0))
                                            ),

                                            child: Padding(
                                              padding:  EdgeInsets.all(3.0),
                                              child: Text(post[index],
                                                textAlign:TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 13
                                                ),),
                                            ),
                                          ),
                                          Text(time[index],
                                            textAlign:TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12
                                            ),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  children: [
                                    Text('View Profile ➜', style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.blue

                                    ),),
                                    // Container(
                                    //   width: 10.0,
                                    //   child: IconButton(
                                    //       icon: Icon(Icons.arrow_drop_down_circle),
                                    //       onPressed:(){}),
                                    // )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),*/


/*  Widget buildImage(String hivImage, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Container(

child: Image.asset(hivImage, fit: BoxFit.fill,),
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: carouselHiv.length,

      effect: JumpingDotEffect(
        dotHeight: 10,
        dotWidth: 10,
        // dotColor: Colors.greenAccent,
        // activeDotColor: Color(0xff0D5D40)
      ),
    );
  }
}*/



