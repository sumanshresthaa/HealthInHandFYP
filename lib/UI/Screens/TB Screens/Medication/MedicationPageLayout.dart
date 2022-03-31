import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../../../Methods/Parser/parser.dart';
import '../../../../Models/get_details_of_TBMedication.dart';
import '../../../../Textstyle/constraints.dart';
import '../../../../ViewModel/changenotifier.dart';
import '../../../Extracted Widgets/topicandesc.dart';
import '../../../ScrollableAppBar/backappbar.dart';

class MedicationPageLayout extends StatelessWidget {
  MedicationPageLayout(this.topicBody);
  final Widget topicBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: CustomScrollAppBar(
        topicBody,
        context.watch<DataProvider>().data ? 'Medication' : 'औषधि',
      ),
    );
  }
}

class LayoutContent extends StatefulWidget {
  LayoutContent(this.title, this.indexID);

  final String title;
  final indexID;

  @override
  State<LayoutContent> createState() => _LayoutContentState();
}

class _LayoutContentState extends State<LayoutContent> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopicBar(widget.title, Color(0xff55C9F5)),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              context.watch<DataProvider>().data
                  ? 'Minor Adverse Effects'
                  : 'सामानय प्रतिकुल प्रभावहरु',
              style: kStyleMedMainTitle,
            ),
          ),
          DescriptionContent(widget.indexID),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              context.watch<DataProvider>().data
                  ? 'Major Adverse Effects'
                  : 'प्रमुख प्रतिकुल प्रभावहरु',
              style: kStyleMedMainTitle,
            ),
          ),
          DescriptionContent2(widget.indexID),
        ],
      ),
    );
  }
}

class DescriptionContent extends StatefulWidget {
  DescriptionContent(this.indexID);
  final indexID;

  @override
  State<DescriptionContent> createState() => _DescriptionContentState();
}

class _DescriptionContentState extends State<DescriptionContent> {
  Future<TbMedication>? _tbMedicationID;

  Future<TbMedication> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("tb_medication");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return TbMedication.fromJson(jsonMap);
  }

  @override
  void initState() {
    super.initState();
    _tbMedicationID = getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: FutureBuilder<TbMedication>(
            future: _tbMedicationID,
            builder: (context, snapshot) {
             var medication = snapshot.data!.data.tbMedication[widget.indexID].medicationDetail;

             majorMinorFilter() {
                var minorList = [];
                var majorList = [];
                for (int i = 0; i < medication!.length; i++) {
                  while(medication[i].medicationEffectId == 1) {
                    //medicationEffectId == 1 minor
                    minorList.add(medication[i].effect);
                    print(minorList);

                    return minorList;
                  }
                  /*else if (medication[i].medicationEffectId == 2) {
                    majorList.add(medication[i].effect);
                    print(majorList);

                    return majorList;*/
                  }
                }





              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    children: [
                      Text('Loading'),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                );
              } else
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.watch<DataProvider>().data
                                  ? 'Effects'
                                  : 'असर',
                              style: kStyleMedTitle,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextButton(
                              onPressed: (){

                                majorMinorFilter();

                              },
                              child: Text('test'),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                              itemCount:  snapshot.data!.data.tbMedication[widget.indexID].medicationDetail!.length,
                                itemBuilder: (context, index){
                              return Column(
                                children: [
                                  Text(
                                      ParseContent(context.watch<DataProvider>().data
                                          ? snapshot
                                          .data!
                                          .data
                                          .tbMedication[widget.indexID]
                                          .medicationDetail![index]
                                          .effect
                                          : snapshot
                                          .data!
                                          .data
                                          .tbMedication[widget.indexID]
                                          .medicationDetail![index]
                                          .effectNe)
                                          .parser(),
                                      style: kStyleDescription)

                                ],
                              );
                            }),
                            Text(
                                ParseContent(context.watch<DataProvider>().data
                                        ? snapshot
                                            .data!
                                            .data
                                            .tbMedication[widget.indexID]
                                            .medicationDetail![0]
                                            .effect
                                        : snapshot
                                            .data!
                                            .data
                                            .tbMedication[widget.indexID]
                                            .medicationDetail![0]
                                            .effectNe)
                                    .parser(),
                                style: kStyleDescription)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 16),
                          width: 160,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.watch<DataProvider>().data
                                    ? 'Management'
                                    : 'व्यवस्थापन',
                                style: kStyleMedTitle,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  ParseContent(
                                          context.watch<DataProvider>().data
                                              ? snapshot
                                                  .data!
                                                  .data
                                                  .tbMedication[widget.indexID]
                                                  .medicationDetail![0]
                                                  .management
                                              : snapshot
                                                  .data!
                                                  .data
                                                  .tbMedication[widget.indexID]
                                                  .medicationDetail![0]
                                                  .managementNe)
                                      .parser(),
                                  style: kStyleDescription)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
            }),
      ),
    );
  }
}

class DescriptionContent2 extends StatefulWidget {
  DescriptionContent2(this.indexID);
  final indexID;

  @override
  State<DescriptionContent2> createState() => _DescriptionContent2State();
}

class _DescriptionContent2State extends State<DescriptionContent2> {
  Future<TbMedication>? _tbMedicationID;

  Future<TbMedication> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("tb_medication");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return TbMedication.fromJson(jsonMap);
  }

  @override
  void initState() {
    super.initState();
    _tbMedicationID = getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: FutureBuilder<TbMedication>(
            future: _tbMedicationID,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    children: [
                      Text('Loading'),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                );
              } else
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.watch<DataProvider>().data
                                  ? 'Effects'
                                  : 'असर',
                              style: kStyleMedTitle,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                ParseContent(context.watch<DataProvider>().data
                                        ? snapshot
                                            .data!
                                            .data
                                            .tbMedication[widget.indexID]
                                            .medicationDetail![2]
                                            .effect
                                        : snapshot
                                            .data!
                                            .data
                                            .tbMedication[widget.indexID]
                                            .medicationDetail![2]
                                            .effectNe)
                                    .parser(),
                                style: kStyleDescription)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 16),
                          width: 160,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.watch<DataProvider>().data
                                    ? 'Management'
                                    : 'व्यवस्थापन',
                                style: kStyleMedTitle,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  ParseContent(
                                          context.watch<DataProvider>().data
                                              ? snapshot
                                                  .data!
                                                  .data
                                                  .tbMedication[widget.indexID]
                                                  .medicationDetail![1]
                                                  .management
                                              : snapshot
                                                  .data!
                                                  .data
                                                  .tbMedication[widget.indexID]
                                                  .medicationDetail![1]
                                                  .managementNe)
                                      .parser(),
                                  style: kStyleDescription),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
            }),
      ),
    );
  }
}
