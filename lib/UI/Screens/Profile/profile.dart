import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/get_email.dart';
import '../../../Network/NetworkHelper.dart';
import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../BottomNavigations/bottom_navigation_covid.dart';
import '../../BottomNavigations/bottom_navigation_hiv.dart';
import '../../BottomNavigations/bottom_navigation_tb.dart';
import '../../ScrollableAppBar/backappbar.dart';
import '../Hotline Numbers/hotline_numbers.dart';

class Profile extends StatefulWidget {



  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late bool englishLanguage = context.watch<DataProvider>().data;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: ScrollAppBarNoRightArrow(ProfileContent(),
          englishLanguage ? "Profile" : 'प्रोफाइल'),
    );
  }
}

class ProfileContent extends StatefulWidget {

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  late var token = Provider.of<DataProvider>(context, listen: false).tokenValue;
  late bool englishLanguage = context.watch<DataProvider>().data;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: [
          Column(
            children: [
              ProfileDetails(),

              ProfileList(
                  englishLanguage
                      ? 'Change Password'
                      : 'पासवर्ड परिवर्तन गर्नुहोस्',
                  'assets/lock.png', () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BottomNavigationCovid();
                }));
              }),
              ProfileList(
                  englishLanguage
                      ? 'Hotline Numbers'
                      : 'औषधी अनुस्मारक परिवर्तन गर्नुहोस्',
                  'assets/hotline.png', () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HotlineNumbersScreen();
                }));
              }),
              ProfileList(
                englishLanguage ? 'Logout' : 'बाहिर निस्कनु  ',
                'assets/logout.png',
                () async {
                  await NetworkHelper()
                      .getLogoutData('http://103.109.230.18/api/logout', token);
                  final SharedPreferences sPreference =
                      await SharedPreferences.getInstance();
                  sPreference.remove('token');
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    if(sPreference.getString('choosePreference') == 'hiv'){
                      return BottomNavigationHiv();
                    }
                    else if(sPreference.getString('choosePreference') == 'covid'){
                      return BottomNavigationCovid();
                    }
                    else{
                      return BottomNavigationTB();
                    }

    }

                  ));
                 /* Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);*/
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileDetails extends StatefulWidget {
  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}


class _ProfileDetailsState extends State<ProfileDetails> {
  late String name = context.watch<DataProvider>().cpName;
  late var email = Provider.of<DataProvider>(context, listen: false).emailValue;
  late var phone = Provider.of<DataProvider>(context, listen: false).phoneNumValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0, top: 24),
      child: GestureDetector(
        onTap: () {},
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      'assets/profilepic.png',
                      width: 54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$name',
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(Icons.mail_outline,
                                size: 20, color: Color(0xff3F84FC)),
                            SizedBox(
                              width: 9,
                            ),
                            Text(email),
                          ],
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(Icons.phone_outlined,
                                size: 20, color: Color(0xff3F84FC)),
                            SizedBox(
                              width: 9,
                            ),
                            Text(phone),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class ProfileList extends StatelessWidget {
  ProfileList(this.profileContents, this.icon, this.onPress);

  final String profileContents;
  final icon;
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
                    color: Color(0xff27B799),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ImageIcon(
                        AssetImage(icon,),
                        color: Color(0xff3F84FC),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        profileContents,
                        style: kStyleContent,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xffF3F7FF),
                      child:
                          Icon(Icons.chevron_right, color: Color(0xff324F81)),
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
