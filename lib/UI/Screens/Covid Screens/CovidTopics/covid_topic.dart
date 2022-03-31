import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../Models/get_details_of_covid.dart';
import '../../../../ViewModel/changenotifier.dart';
import '../../../Extracted Widgets/buttons.dart';
import '../../../Extracted Widgets/topicandesc.dart';


//Main description of a topic of covid
class CovidTopic extends StatefulWidget {
  CovidTopic(this.label, this.indexID, this.list, this.topicBody);

  final label;
  var indexID;
  final list;
  final Widget topicBody;

  @override
  State<CovidTopic> createState() => _CovidTopicState();
}

class _CovidTopicState extends State<CovidTopic> {
  Future<DetailsOfCovid>? _covidHome;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _covidHome = getApiData();
  }

  //Calling the api cache manager
  Future<DetailsOfCovid> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("covid_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfCovid.fromJson(jsonMap);
  }

  AudioPlayer? _player;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF3F7FF),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff324F81)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            _player!.pause(); //When the back button is pressed it automatically pauses the audio
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 18,
              top: 16,
              bottom: 16,
              right: 14,
            ),
            child: Image.asset(
              'assets/arrow.png',
            ),
          ),
        ),
        title: Text(
          widget.label,
          style: TextStyle(
            fontFamily: "NutinoSansReg",
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xff324F81),
          ),
        ),
        centerTitle: true,
      ),
      endDrawer: Drawer(),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: [
            FutureBuilder<DetailsOfCovid>(
                future: _covidHome,
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
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 41.5),
                          child: Image.asset('assets/topic_content.png',
                              width: 165, height: 175),
                        ),
                        DescriptionContent(
                          (widget.list[widget.indexID].children.length != 0)
                              ? (context.watch<DataProvider>().data)
                                  ? widget
                                      .list[widget.indexID].children[0].name
                                  : widget
                                      .list[widget.indexID].children[0].nameNe
                              : (context.watch<DataProvider>().data)
                                  ? "No data."
                                  : "दाता छैन.",
                          (context.watch<DataProvider>().data)
                              ? widget.list[widget.indexID].name
                              : widget.list[widget.indexID].nameNe,
                        ),
                      ],
                    );
                }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
            if (widget.indexID != (widget.list.length - 1) &&
                widget.indexID != 0)
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
      ),
    );
  }
}

class CovidTopicContent extends StatefulWidget {
  CovidTopicContent(this.indexID, this.list);

  var indexID;
  final list;

  @override
  State<CovidTopicContent> createState() => _CovidTopicContentState();
}

class _CovidTopicContentState extends State<CovidTopicContent> {
  Future<DetailsOfCovid>? _covidHome;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _covidHome = getApiData();
  }

  Future<DetailsOfCovid> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("covid_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfCovid.fromJson(jsonMap);
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
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 41.5),
                        child: Image.asset('assets/topic_content.png',
                            width: 165, height: 175),
                      ),
                      DescriptionContent(
                        (widget.list[widget.indexID].children.length != 0)
                            ? (context.watch<DataProvider>().data)
                                ? widget.list[widget.indexID].children[0].name
                                : widget
                                    .list[widget.indexID].children[0].nameNe
                            : (context.watch<DataProvider>().data)
                                ? "No data."
                                : "दाता छैन.",
                        (context.watch<DataProvider>().data)
                            ? widget.list[widget.indexID].name
                            : widget.list[widget.indexID].nameNe,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 42.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (widget.indexID != 0)
                              PreviousBtn(() {
                                setState(() {
                                  widget.indexID--;
                                });
                              }),
                            if (widget.indexID != (widget.list.length - 1))
                              NextBtn(() {
                                setState(() {
                                  widget.indexID++;
                                });
                              }),
                          ],
                        ),
                      ),
                    ],
                  );
              }),
        ],
      ),
    );
  }
}

//
//
