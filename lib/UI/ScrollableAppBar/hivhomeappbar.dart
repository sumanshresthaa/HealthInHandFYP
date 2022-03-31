import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Screens/HIV Screens/athritis_home.dart';

class ScrollAppBar extends StatelessWidget {
  final Widget bodypass;
  final String text;
  ScrollAppBar(this.bodypass, this.text);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            text,
            style: TextStyle(
              fontFamily: "NutinoSansBold",
              fontSize: 16,
              color: Color(0xFF5686D8),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    (MaterialPageRoute(
                      builder: (context) {
                        return HivHome();
                      },
                    )));
              },
              icon: Icon(
                Icons.search,
                color: Color(0xFF5686D8),
              ),
            ),
          ],
          centerTitle: true,
        )
      ],
      body: bodypass,
    );
  }
}
