import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../Models/get_details_of_Arthritis.dart';
import '../../../../ViewModel/changenotifier.dart';
import '../../../Extracted Widgets/buttons.dart';
import '../../../Extracted Widgets/topicandesc.dart';

class HIVTopic extends StatefulWidget {
  HIVTopic(this.label, this.indexID, this.list);

  final label;
  var indexID;
  final list;

  @override
  State<HIVTopic> createState() => _HIVTopicState();
}

class _HIVTopicState extends State<HIVTopic> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _arthritisHome = getApiData();
  }

  Future<DetailsOfArthritis>? _arthritisHome;

  Future<DetailsOfArthritis> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("arthritis_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfArthritis.fromJson(jsonMap);
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
            _player!.pause();
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
        centerTitle: false,
      ),
      endDrawer: Drawer(),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: [
            FutureBuilder<DetailsOfArthritis>(
                future: _arthritisHome,
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
/*
class TopicContent extends StatefulWidget {
  TopicContent(this.indexID, this.list);

  var indexID;
  final list;

  @override
  State<TopicContent> createState() => _TopicContentState();
}

class _TopicContentState extends State<TopicContent> {
  Future<DetailsOfHiv>? _hivHome;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _hivHome = getApiData();
  }

  Future<DetailsOfHiv> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("hiv_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfHiv.fromJson(jsonMap);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: [
          FutureBuilder<DetailsOfHiv>(
              future: _hivHome,
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
                        (widget.list[widget.indexID].content.length != 0)
                            ? (context.watch<DataProvider>().data)
                                ? widget.list[widget.indexID].content[0].content
                                : widget
                                    .list[widget.indexID].content[0].contentNe
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
}*/

//
//
