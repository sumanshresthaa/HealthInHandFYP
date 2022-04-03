import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Screens/Arthritis%20Screens/Medication/treatmentforhivlayout.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Models/get_details_of_HivMedication.dart';
import '../../../../ViewModel/changenotifier.dart';
import '../../../Extracted Widgets/content_list_index.dart';
import '../../../ScrollableAppBar/backappbar.dart';

class TreatmentForHiv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: ScrollAppBarNoLeftArrow(
          TreatmentForHivContent(),
          context.watch<DataProvider>().data
              ? 'Treatment for HIV'
              : 'यच.आइ.भि. को जाच '),
    );
  }
}

class TreatmentForHivContent extends StatefulWidget {
  @override
  _TreatmentForHivContentState createState() => _TreatmentForHivContentState();
}

class _TreatmentForHivContentState extends State<TreatmentForHivContent> {
  Future<HivMedication>? _hivMedication;

  Future<HivMedication> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("hiv_treatments");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return HivMedication.fromJson(jsonMap);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    //updateUI(widget.medicationList);
    _hivMedication = getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: [
          FutureBuilder<HivMedication>(
              future: _hivMedication,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 800,
                    child: Shimmer.fromColors(
                      direction: ShimmerDirection.ltr,
                      period: const Duration(milliseconds: 8000),
                      child: ListView.builder(
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              height: 50,
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
                }
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.data!.hivMedication!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var textLabel =
                          snapshot.data!.data!.hivMedication![index];
                      return ContentListIndex(
                          context.watch<DataProvider>().data
                              ? textLabel.topicEn
                              : textLabel.topicNe,
                          Icons.chevron_right,
                          Color(0xff55C9F5),
                          index,
                          TreatmentHivPageLayout(HivTopicContent(index)));
                    });
              })
        ],
      ),
    );
  }
}
