import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Textstyle/constraints.dart';


//In the content shown page. The next button and previous buttom ui.
class NextBtn extends StatelessWidget {

  NextBtn(this.onPress);
  final onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 92,
        child: ElevatedButton(
          onPressed: onPress,
          child: Text('Next'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff0D5D40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ))),
        ),
      ),
    );
  }
}

//Previous button page
class PreviousBtn extends StatelessWidget {
  PreviousBtn(this.onPress);
  final onPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 92,
        child: ElevatedButton(
          onPressed: onPress,
          child: Text(
            'Previous',
            style: TextStyle(color: Color(0xffFFFFFF)),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xffA3A3A3)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              side: MaterialStateProperty.all(
                  BorderSide(color: Color(0xffA3A3A3)))),
        ),
      ),
    );
  }
}

//Important button: Use case Select Language, purpose
class LangButton extends StatelessWidget {
  LangButton(
    this.onPress,
    this.label,
  );
  final onPress;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 60),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey,
              width: 0.6,
            )),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: kStyleSelect,
          ),
        )),
      ),
    );
  }
}

//Login Button in login Page
class LoginButton extends StatelessWidget {
  LoginButton(this.text, this.onPress);
  final text;
  final onPress;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Ink(
        decoration: BoxDecoration(
            color: Color(0xff0D5D40), borderRadius: BorderRadius.circular(24)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

//Used mostly for exit
class WhiteButton extends StatelessWidget {
  WhiteButton(this.text, this.onPress);

  final text;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(24)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff333333),
            ),
          ),
        ),
      ),
    );
  }
}


//Button for going next in appointment
class AppointmentButton extends StatelessWidget {
  const AppointmentButton({required this.text, this.onPress});

  final text;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 49,
        child: ElevatedButton(
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 12.sp,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(const Color(0xff00A6FB)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)))),
        ),
      ),
    );
  }
}


//For reciept page only
class BlueButton extends StatelessWidget {
  BlueButton(this.text, this.onPress);

  final text;
  final onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Ink(
        decoration: BoxDecoration(
            color:Color(0xff3FA5DF), borderRadius: BorderRadius.circular(24)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
