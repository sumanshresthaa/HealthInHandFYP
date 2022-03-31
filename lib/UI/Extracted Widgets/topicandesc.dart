import 'dart:io' show Platform;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Methods/Parser/parser.dart';
import '../../Textstyle/constraints.dart';


//The main information content in the app
//TODO Change audio api
class TopicBar extends StatelessWidget {
  TopicBar(this.setting, this.color);

  final String? setting;
  final color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 4, 16, 16),
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
                  height: 36,
                  width: 4,
                  decoration: BoxDecoration(
                    color: color,
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
                    Expanded(
                      child: Text(
                        setting!,
                        style: kStyleContent,
                      ),
                    ),
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

//The body of the main topic
class DescriptionContent extends StatefulWidget {
  final content;
  final topic;
  DescriptionContent(this.content, this.topic);

  @override
  State<DescriptionContent> createState() => _DescriptionContentState();
}

class _DescriptionContentState extends State<DescriptionContent>
    with WidgetsBindingObserver {
  bool playing = false;
  String playBtn = 'assets/play.png';

  AudioPlayer? _player;
  AudioCache? cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 3,
        activeTrackColor: Color(0xff324F81),
        inactiveTrackColor: Color(0xffE1E4EC),
        thumbColor: Color(0xff324F81),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.33),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 15),
      ),
      child: Container(
        width: 242,
        child: Slider.adaptive(
            value: position.inSeconds.toDouble(),
            max: musicLength.inSeconds.toDouble(),
            onChanged: (value) {
              seekToSec(value.toInt());
            }),
      ),
    );
  }

  Widget sliderIos() {
    return Container(
      width: 242,
      child: CupertinoSlider(
          activeColor: Color(0xff324F81),
          value: 0,
          max: 100,
          onChanged: (value) {
            /*   seekToSec(value.toInt());*/
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player!.seek(newPos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player!.onDurationChanged.listen((d) {
      setState(() => musicLength = d);
    });

    _player!.onAudioPositionChanged.listen((d) {
      setState(() => position = d);
    });

    /*cache!.load("livemylife.mp3");*/
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player!.pause();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _player!.pause();
    WidgetsBinding.instance!.removeObserver(this);
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
                    '${widget.topic}',
                    style: kStyleHContent,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!playing) {
                            _player!.play(
                                'http://192.168.50.131:8078/uploads/1638866494');
                            setState(() {
                              playBtn = 'assets/pause.png';
                              playing = true;
                            });
                          } else {
                            _player!.pause();
                            setState(() {
                              playBtn = 'assets/play.png';
                              playing = false;
                            });
                          }
                        },
                        child: Image.asset(
                          playBtn,
                          width: 32,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                            style: kStyleMusicTxt,
                          ),
                          Platform.isIOS ? sliderIos() : slider(),
                          Text(
                            "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                            style: kStyleMusicTxt,
                          ),
                        ],
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    ParseContent(widget.content).parser(),
                    //Bidi.stripHtmlIfNeeded(widget.content),
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
