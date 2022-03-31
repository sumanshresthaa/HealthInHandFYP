import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/src/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Models/hotline_numbers.dart';
import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../ScrollableAppBar/backappbar.dart';

class HotlineNumbersScreen extends StatefulWidget {
  @override
  State<HotlineNumbersScreen> createState() => _HotlineNumbersScreenState();
}

class _HotlineNumbersScreenState extends State<HotlineNumbersScreen> {
  late bool englishLanguage = context.watch<DataProvider>().data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: ScrollAppBarNoRightArrow(HotlineNumberContent(),
          englishLanguage ? "Hotline Numbers" : 'फोन नम्बर'),
    );
  }
}

class HotlineNumberContent extends StatefulWidget {
  @override
  State<HotlineNumberContent> createState() => _HotlineNumberContentState();
}

class _HotlineNumberContentState extends State<HotlineNumberContent> {
  Future<HotlineNumbers>? _hotlineNumbers;

  Future<HotlineNumbers> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("hotline_numbers");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return HotlineNumbers.fromJson(jsonMap);
  }

  late bool englishLanguage = context.watch<DataProvider>().data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hotlineNumbers = getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              FutureBuilder<HotlineNumbers>(
                  future: _hotlineNumbers,
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
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.data!.hotline!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var value = snapshot.data!.data!.hotline![index];
                            return HotlineNumberList(
                              value!.name,
                              value.address,
                              value.contactNo,
                            );
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class HotlineNumberList extends StatelessWidget {
  HotlineNumberList(
    this.profileContents,
    this.location,
    this.phoneNumber,
  );

  final String? profileContents;
  final String? location;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  height: 57,
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Color(0xff324F81),
                              ),
                              Text('$location')
                            ],
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            '$profileContents',
                            style: kStyleContent,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '0$phoneNumber',
                            style: kStyleHotlineNumber,
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xffF3F7FF),
                      child: GestureDetector(
                          onTap: () async {
                            var url = phoneNumber;
                            print(phoneNumber);
                            launch('tel://$phoneNumber');
                          },
                          child: Icon(Icons.phone_outlined,
                              color: Color(0xff324F81))),
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
