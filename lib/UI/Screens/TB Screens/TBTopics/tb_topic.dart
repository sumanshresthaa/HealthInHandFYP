import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../Methods/InternetCheck/checkinternet.dart';
import '../../../../Models/get_details_of_tb.dart';
import '../../../../ViewModel/changenotifier.dart';
import '../../../Extracted Widgets/buttons.dart';
import '../../../Extracted Widgets/topicandesc.dart';

class TBTopic extends StatefulWidget {
  TBTopic(this.label, this.indexID, this.list);

  final label;
  var indexID;
  final list;

  @override
  State<TBTopic> createState() => _TBTopicState();
}

class _TBTopicState extends State<TBTopic> {
  Future<DetailsOfTB>? _tbHome;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tbHome = getApiData();
  }

  Future<DetailsOfTB> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("tb_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfTB.fromJson(jsonMap);
  }

  void networkCheck() async {
    await internetConnection() == true;
  }

  var url = "http://103.109.230.18/";

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
        centerTitle: true,
      ),
      endDrawer: Drawer(),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: [
            FutureBuilder<DetailsOfTB>(
                future: _tbHome,
                builder: (context, snapshot) {
                  var imageIndex = widget.list[widget.indexID].content[0].image;
                  if (snapshot.hasError) {
                    Text("Error");
                  }
                  /*      if (snapshot.connectionState) {
                    Text("Error");
                  }*/
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
                          child: imageIndex != null
                              ? Image.network(
                                  "$url$imageIndex",
                                  fit: BoxFit.cover,
                                )
                              : Image.asset('assets/topic_content.png',
                                  width: 165, height: 175),
                        ),
                        DescriptionContent(
                          (widget.list[widget.indexID].content.length != 0)
                              ? (context.watch<DataProvider>().data)
                                  ? widget
                                      .list[widget.indexID].content[0].content
                                  : widget
                                      .list[widget.indexID].content[0].contentNe
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
class TBTopicContent extends StatefulWidget {
  TBTopicContent(this.indexID, this.list);

  var indexID;
  final list;

  @override
  State<TBTopicContent> createState() => _TBTopicContentState();
}

class _TBTopicContentState extends State<TBTopicContent> {
  Future<DetailsOfTB>? _tbHome;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _tbHome = getApiData();
  }

  Future<DetailsOfTB> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("tb_details");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfTB.fromJson(jsonMap);
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
                      Text('hi'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 41.5),
                        child: Image.network(
                            'http://103.109.230.18/uploads/1643604344.png',
                            width: 165,
                            height: 175),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 41.5),
                        child: Image.network(
                            'http://103.109.230.18/uploads/1643604344.png',
                            width: 165,
                            height: 175),
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
