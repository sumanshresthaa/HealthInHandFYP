import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

//Not needed right now but shows a bottom sheet when deleting

/*class DeleteBSheet extends StatelessWidget {
  DeleteBSheet(this.onTap);
  final onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 24.0, right: 24.0, top: 16, bottom: 32.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 24,
                    child: Divider(
                      color: Color(0xffA3A3A3),
                      thickness: 2,
                      height: 2,
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delete post',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'NutinoSansReg',
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: onTap,
                        child: Image.asset(
                          'assets/circledelete.png',
                          width: 36,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
