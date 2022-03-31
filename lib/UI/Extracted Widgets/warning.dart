import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../Textstyle/constraints.dart';
import '../../ViewModel/changenotifier.dart';


//Present in the medication page of tb with the red warning
class Warning extends StatelessWidget {
  Warning(this.text, this.color);

  final String text;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                height: 94,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: kStyleTime.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: Text(
                      context.watch<DataProvider>().data
                          ? 'Please be warned you need to take the medicine under the Directly Observed Treatment Service (DOTS)'
                          : 'कृपया सचेत रहनुहोल, तपाईंले प्रत्यक्ष  रुपमा अवलोकन गरिएको उपचार (डट्स) अन्तर्गत औषधी लिनु पर्छ ।',
                      style: kStyleCheckedIn.copyWith(
                          color: Colors.grey, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
