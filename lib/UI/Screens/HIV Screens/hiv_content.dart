import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Models/get_details_of_Arthritis.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../Extracted Widgets/content_list_topic.dart';
import '../../ScrollableAppBar/backappbar.dart';
import 'HIVTopics/hiv_topic.dart';

class AboutHivPage extends StatelessWidget {
  AboutHivPage({this.indexId, this.label});

  final indexId;
  final label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: CustomScrollAppBar(
          AboutHivDetail(
            indexId: indexId,
            label1: label,
          ),
          label),
    );
  }
}

class AboutHivDetail extends StatefulWidget {
  AboutHivDetail({this.indexId, this.label1});
  final indexId;
  final label1;

  @override
  _AboutHivDetailState createState() => _AboutHivDetailState();
}

class _AboutHivDetailState extends State<AboutHivDetail> {
  int? itemLength;
  Future<DetailsOfArthritis>? _arthritisHome;

  Future<DetailsOfArthritis> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("arthritis_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfArthritis.fromJson(jsonMap);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _arthritisHome = getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: [
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
                              height: 70,
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
                    itemCount: snapshot.data!.data!.arthritisDetails![widget.indexId].children!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var textLabel = snapshot.data!.data!
                          .arthritisDetails![widget.indexId].children![index];
                      return ContentListTopic(
                        context.read<DataProvider>().data
                            ? textLabel.name
                            : textLabel.nameNe,
                        Icons.chevron_right,
                        Colors.teal[400],
                        HIVTopic(
                          widget.label1,
                          index,
                          snapshot.data!.data!.arthritisDetails![widget.indexId].children,
                        ),
                      );
                    });
              })
        ],
      ),
    );
  }
}
