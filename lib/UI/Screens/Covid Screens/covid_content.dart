import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Models/get_details_of_covid.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../Extracted Widgets/content_list_topic.dart';
import '../../ScrollableAppBar/backappbar.dart';
import 'CovidTopics/covid_topic.dart';

class AboutCovidPage extends StatelessWidget {
  AboutCovidPage({this.indexId, this.label});

  final indexId;
  final label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      body: CustomScrollAppBar(
          AboutCovidDetail(
            indexId: indexId,
            label1: label,
          ),
          label),
    );
  }
}

class AboutCovidDetail extends StatefulWidget {
  AboutCovidDetail({this.indexId, this.label1});
  final indexId;
  final label1;

  @override
  _AboutCovidDetailState createState() => _AboutCovidDetailState();
}

class _AboutCovidDetailState extends State<AboutCovidDetail> {
  int? itemLength;
  Future<DetailsOfCovid>? _covidHome;
  List<String?> storingName = [];

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

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: [
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
                    itemCount: snapshot.data!.data!
                        .covidDetails![widget.indexId].children!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var textLabel = snapshot.data!.data!
                          .covidDetails![widget.indexId].children![index];
                      return ContentListTopic(
                        context.read<DataProvider>().data
                            ? textLabel.name
                            : textLabel.nameNe,
                        Icons.chevron_right,
                        Colors.teal[400],
                        CovidTopic(
                          widget.label1,
                          index,
                          snapshot.data!.data!.covidDetails![widget.indexId]
                              .children,
                          CovidTopicContent(
                              index,
                              snapshot.data!.data!
                                  .covidDetails![widget.indexId].children),
                        ),
                      );
                    });
              })
        ],
      ),
    );
  }
}
