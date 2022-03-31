import 'package:flutter/material.dart';
import '../../Textstyle/constraints.dart';


//Important Page: UI for home page. Directly called from hiv,tb and covid home
class HomeContents extends StatelessWidget {
  HomeContents({this.text, this.image, this.page});

  final text;
  final image;
  final page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return page;
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                /*   decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xffFFFFFF),
                ),*/
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 148,
                      width: double.infinity,
                      child: Image(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 34,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            text,
                            style: kStyleHome,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContentsFAQ extends StatelessWidget {
  HomeContentsFAQ({this.text, this.image, this.page});

  final text;
  final image;
  final page;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return page;
              }));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 0.5), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 148,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 34,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          text,
                          style: kStyleHome,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
