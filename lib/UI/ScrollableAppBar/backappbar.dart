import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../BottomNavigations/bottom_navigation_covid.dart';
import '../BottomNavigations/bottom_navigation_hiv.dart';
import '../BottomNavigations/bottom_navigation_tb.dart';

class CustomScrollAppBar extends StatelessWidget {
  final Widget bodypass;
  final String text;

  CustomScrollAppBar(this.bodypass, this.text);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
            text,
            style: TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff324F81),
            ),
          ),
          centerTitle: true,
        )
      ],
      body: bodypass,
    );
  }
}

class BackAppBar extends StatelessWidget {
  final Widget bodyPass;
  final Color color;

  BackAppBar(
      this.bodyPass,
      this.color,
      );

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          backgroundColor: color,

          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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

          centerTitle: true,
        )
      ],
      body: bodyPass,
    );
  }
}

class CustomNavScrollAppBar extends StatelessWidget {
  final Widget bodypass;
  final String text;

  CustomNavScrollAppBar(this.bodypass, this.text);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () async {
              final SharedPreferences sPreference =
              await SharedPreferences.getInstance();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                if (sPreference.getString('choosePreference') == 'hiv') {
                  return BottomNavigationHiv();
                } else if (sPreference.getString('choosePreference') ==
                    'covid') {
                  return BottomNavigationCovid();
                } else {
                  return BottomNavigationTB();
                }
              }));
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
            text,
            style: TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff324F81),
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Image.asset(
                  'assets/rightarrow.png',
                  width: 20,
                ),
              ),
            ),
          ],
        )
      ],
      body: bodypass,
    );
  }
}

class ScrollAppBarNoLeftArrow extends StatelessWidget {
  final Widget bodypass;
  final String text;

  ScrollAppBarNoLeftArrow(this.bodypass, this.text);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.white,
          title: Text(
            text,
            style: TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff324F81),
            ),
          ),
          centerTitle: true,
          /*    actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Image.asset(
                  'assets/rightarrow.png',
                  width: 20,
                ),
              ),
            ),
          ],*/
        )
      ],
      body: bodypass,
    );
  }
}

class ScrollAppBarNoRightArrow extends StatelessWidget {
  final Widget bodypass;
  final String text;

  ScrollAppBarNoRightArrow(this.bodypass, this.text);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
            text,
            style: TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff324F81),
            ),
          ),
          centerTitle: true,
        )
      ],
      body: bodypass,
    );
  }
}

/*
class BackAppBar extends StatelessWidget with PreferredSizeWidget {
  const BackAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
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
    );
  }
}
*/

class GRCustomScrollAppBar extends StatelessWidget {
  final Widget bodypass;
  final String text;
  final image;
  final onPress;

  GRCustomScrollAppBar(this.bodypass, this.text, this.image, this.onPress);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
            text,
            style: TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff324F81),
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: onPress,
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Image.asset(
                  image,
                  width: 20,
                ),
              ),
            ),
          ],
        )
      ],
      body: bodypass,
    );
  }
}



class ChatAppBar extends StatelessWidget with PreferredSizeWidget {
  ChatAppBar({required this.title});
  final title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/arrow.png',
            width: 11.43,
            height: 20,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'NutinoSansReg',
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xff324F81),
        ),
      ),
      /* toolbarHeight: 60,*/
      titleSpacing: 16,
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
