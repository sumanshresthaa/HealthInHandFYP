import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../Textstyle/constraints.dart';
import '../UI/BottomNavigations/bottom_navigation_tb.dart';
import '../UI/Extracted Widgets/buttons.dart';
import '../UI/ScrollableAppBar/backappbar.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

class TBNotification extends StatefulWidget {
  @override
  _TBNotificationState createState() => _TBNotificationState();
}

class _TBNotificationState extends State<TBNotification> {
  @override
  void initState() {
    initializeSetting();
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BackAppBar(
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do you want to receive\nreminder of TB medication at\n9am and 2pm everyday?',
                        style: kStyleNotification,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Select Answer',
                        style: kStyleTime,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0, bottom: 16),
                        child: LangButton(
                          () async {
                            await displayNotification2(
                                'Reminder for TB patient');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BottomNavigationTB();
                                },
                              ),
                            );
                            await displayNotification(
                                'Reminder for TB patient');

                            print('ok');
                          },
                          'Yes',
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      LangButton(
                        () async {
                          await notificationsPlugin.cancel(2);
                          await notificationsPlugin.cancel(3);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BottomNavigationTB();
                              },
                            ),
                          );
                        },
                        'No',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Colors.white,
      ),
    );
  }

  Future<void> displayNotification(String heading) async {
    notificationsPlugin.zonedSchedule(
        2,
        heading,
        'It\'s time to take medicine.',
        _scheduleDaily(Time(8, 15, 0)),
/*
        tz.TZDateTime.now(tz.local).add(
          Duration(seconds: 5),
        ),*/
        await NotificationDetails(
          android: AndroidNotificationDetails(
              'channel id', 'channel name', 'channel description'),
          iOS: IOSNotificationDetails(),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }

  Future<void> displayNotification2(String heading) async {
    notificationsPlugin.zonedSchedule(
        3,
        heading,
        'It\'s time to take medicine.',
        _scheduleDaily2(Time(3, 15, 0)),

        /*       tz.TZDateTime.now(tz.local).add(
          Duration(seconds: 10),
        ),*/
        await NotificationDetails(
          android: AndroidNotificationDetails(
              'channel id', 'channel name', 'channel description'),
          iOS: IOSNotificationDetails(),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static tz.TZDateTime _scheduleDaily2(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }
}

void initializeSetting() async {
  var initializeAndroid = AndroidInitializationSettings('app_icon');
  var initialIOS = IOSInitializationSettings();
  var initialSettings =
      InitializationSettings(android: initializeAndroid, iOS: initialIOS);
  await notificationsPlugin.initialize(initialSettings);
}
