import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../../../Methods/Parser/parser.dart';
import '../../../../Models/get_details_of_HivMedication.dart';
import '../../../../Textstyle/constraints.dart';
import '../../../../ViewModel/changenotifier.dart';
import '../../../Extracted Widgets/topicandesc.dart';
import '../../../ScrollableAppBar/backappbar.dart';

class TreatmentHivPageLayout extends StatelessWidget {
  TreatmentHivPageLayout(this.topicBody);
  final Widget topicBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: CustomScrollAppBar(
        topicBody,
        context.watch<DataProvider>().data
            ? 'Treatment for HIV'
            : 'यच.आइ.भि. को जाच ',
      ),
    );
  }
}

class HivTopicContent extends StatefulWidget {
  HivTopicContent(this.indexID);

  var indexID;

  @override
  State<HivTopicContent> createState() => _HivTopicContentState();
}

class _HivTopicContentState extends State<HivTopicContent> {
  Future<HivMedication>? _hivMedication;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _hivMedication = getApiData();
  }

  // Future<HivMedication> getApiData() async {
  //   var jsonData = await NetworkHelper()
  //       .getData('http://192.168.50.131:8078/api/getMedicationHiv');
  //   var detailsOfHiv = HivMedication.fromJson(jsonData);
  //   return detailsOfHiv;
  // }

  Future<HivMedication> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("hiv_treatments");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return HivMedication.fromJson(jsonMap);
  }

  var list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: [
            FutureBuilder<HivMedication>(
                future: _hivMedication,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    list = snapshot
                        .data!.data!.hivMedication![widget.indexID].effects;
                    return Center(
                      child: Column(
                        children: [
                          Text('Loading'),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ],
                      ),
                    );
                  } else
                    return Column(
                      children: [
                        TopicBar(
                            (context.watch<DataProvider>().data)
                                ? snapshot.data!.data!
                                    .hivMedication![widget.indexID].topicEn
                                //? widget.list[widget.indexID].name
                                : snapshot.data!.data!
                                    .hivMedication![widget.indexID].topicNe,
                            Color(0xff55C9F5)),
                        DescriptionContentTH(
                          (snapshot.data!.data!.hivMedication![widget.indexID]
                                      .effects!.length !=
                                  0)
                              ? (context.watch<DataProvider>().data)
                                  ? snapshot
                                      .data!
                                      .data!
                                      .hivMedication![widget.indexID]
                                      .effects![0]
                                      .contentEn
                                  : snapshot
                                      .data!
                                      .data!
                                      .hivMedication![widget.indexID]
                                      .effects![0]
                                      .contentNe
                              : (context.watch<DataProvider>().data)
                                  ? "No data."
                                  : "दाता छैन.",
                        ),
                      ],
                    );
                }),
          ],
        ),
      ),
/*      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.width * 0.15.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.indexID != 0)
              PreviousBtn(() {
                setState(() {
                  widget.indexID--;
                });
              }),
            if (widget.indexID != (list - 1) && widget.indexID != 0)
              NextBtn(() {
                setState(() {
                  widget.indexID++;
                });
              }),
            if (widget.indexID == 0)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    NextBtn(() {
                      setState(() {
                        widget.indexID++;
                      });
                    }),
                  ],
                ),
              ),
          ],
        ),
      ),*/
    );
  }
}

class DescriptionContentTH extends StatefulWidget {
  final content;
  DescriptionContentTH(
    this.content,
  );

  @override
  State<DescriptionContentTH> createState() => _DescriptionContentState();
}

class _DescriptionContentState extends State<DescriptionContentTH>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 16),
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
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ParseContent(widget.content).parser(),
                    style: kStyleDescription,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
