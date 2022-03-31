import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Textstyle/constraints.dart';


//Treatment of HIV and medication of TB content list like 'Follow up, ART etc' are included here.
class ContentListIndex extends StatelessWidget {
  ContentListIndex(this.text, this.icon, this.color, this.indexID, this.page);

  final String? text;
  final IconData icon;
  final indexID;
  final color;
  final page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return page;
        }));
      },
      child: Container(
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
                      '$text',
                      style: kStyleContent,
                    )),
                    CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.blue[50],
                        child: Icon(
                          icon,
                          size: 25,
                          color: Colors.blueAccent[100],
                        ))
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
