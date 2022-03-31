import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';


//Will pop scope show dialog box UI
Future<void> showBackDialog(BuildContext context) => showDialog(
      barrierColor: Colors.blueAccent.withOpacity(0.3),
      barrierDismissible: false,
      context: context,
      builder: (_) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 145,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100]),
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Are you sure you want to exit?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'NutinoSansReg',
                      letterSpacing: 0.4,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          /*    willLeave = false;*/
                          SystemNavigator.pop();
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: 'NutinoSansReg',
                            letterSpacing: 0.4,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontFamily: 'NutinoSansReg',
                            letterSpacing: 0.4,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
