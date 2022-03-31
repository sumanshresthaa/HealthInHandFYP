import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Models/get_details_of_tb.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../Extracted Widgets/content_list_topic.dart';
import '../../ScrollableAppBar/backappbar.dart';
import 'TBTopics/tb_topic.dart';

class AboutTBPage extends StatelessWidget {
  AboutTBPage({this.indexId, this.label});

  final indexId;
  final label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: CustomScrollAppBar(
          AboutTBDetail(
            indexId: indexId,
            label: label,
          ),
          label),
    );
  }
}

class AboutTBDetail extends StatefulWidget {
  AboutTBDetail({this.indexId, this.label});
  final indexId;
  final label;
  @override
  _AboutTBDetailState createState() => _AboutTBDetailState();
}

class _AboutTBDetailState extends State<AboutTBDetail> {
  int? itemLength;
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

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: [
          FutureBuilder<DetailsOfTB>(
              future: _tbHome,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 800,
                    child: Shimmer.fromColors(
                      direction: ShimmerDirection.ltr,
                      period: const Duration(milliseconds: 1000),
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
                    itemCount: snapshot.data!.data!.tbDetails![widget.indexId]
                        ?.categorySub!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var textLabel = snapshot.data!.data!
                          .tbDetails![widget.indexId]?.categorySub![index];
                      return ContentListTopic(
                        context.read<DataProvider>().data
                            ? textLabel?.name
                            : textLabel?.nameNe,
                        Icons.chevron_right,
                        Colors.teal[400],
                        TBTopic(
                          widget.label,
                          index,
                          snapshot.data!.data!.tbDetails![widget.indexId]
                              ?.categorySub,
                        ),
                      );
                    });
              })
        ],
      ),
    );
  }
}
