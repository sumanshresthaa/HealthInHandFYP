import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sizer/sizer.dart';

// Colors

const kStyleHomeColor = Color(0xffF3F7FF);

var kStyleCheckedIn = TextStyle(
  fontSize: 12.sp,
  fontFamily: 'NutinoSansReg',
  color: Colors.grey,
);

var kStyleTimeComment = TextStyle(
  fontWeight: FontWeight.w600,
  color: Color(0xff777777),
  fontFamily: 'NutinoSansReg',
);

var kStyleReply = TextStyle(
  fontWeight: FontWeight.w600,
  color: Color(0xff3F84FC),
  fontFamily: 'NutinoSansReg',
);

var kStyleTime = TextStyle(
  fontSize: 14.sp,
  fontFamily: 'NutinoSansBold',
  color: Color(0xFF333333),
);

/*---------------------------MUSEO TEXT------------------------*/
var kStyleHomeWelcome = TextStyle(
  fontSize: 13.sp,
  //fontWeight: FontWeight.w100,
  fontFamily: 'Museo Sans Cyrl 500 Regular',
  color: Color(0xFF222B45),
  letterSpacing: 0.25
);

var kStyleMuseoText  = TextStyle(
    fontSize: 13.sp,
    //fontWeight: FontWeight.w100,
    fontFamily: 'Museo Sans Cyrl 500 Regular',
    color: Color(0xFF222B45),
    letterSpacing: 0.25
);
var kStyleMuseoTextContent  = TextStyle(
    fontSize: 11.sp,
    //fontWeight: FontWeight.w100,
    fontFamily: 'NutinoSansReg',
    color: Color(0xFF6B779A),
  fontWeight: FontWeight.w100

);

/*--------------------------------------------------------------*/
var kStyleSelect = TextStyle(
  fontSize: 14.sp,
  fontFamily: 'NutinoSansReg',
  color: Color(0xFF333333),
);

var kStyleNotification = TextStyle(
  fontSize: 14.sp,
  fontFamily: 'NutinoSansReg',
  color: Color(0xFF212121),
);

var kStyleHome = TextStyle(
  fontSize: 10.sp,
  fontFamily: 'NutinoSansReg',
  fontWeight: FontWeight.w700,
  color: Color(0xff333333),
);

var kStyleContent = TextStyle(
  fontSize: 12.sp,
  fontFamily: 'NutinoSansSemiBold',
  color: Color(0xFF324F81),
);

var kStyleHContent = TextStyle(
  fontSize: 12.sp,
  fontFamily: 'NutinoSansReg',
  fontWeight: FontWeight.w700,
  color: Color(0xFF324F81),
);

var kStyleDescription = TextStyle(
  height: 1.25.sp,
  fontSize: 10.sp,
  fontFamily: 'NutinoSansReg',
  fontWeight: FontWeight.w400,
  color: Color(0xFF333333),
);

var kStyleMedTitle = TextStyle(
  fontSize: 12.sp,
  fontFamily: 'NutinoSansSemiBold',
  color: Color(0xFF5686D8),
);

var kStyleMedMainTitle = TextStyle(
  fontSize: 12.sp,
  fontFamily: 'NutinoSansReg',
  color: Color(0xFF333333),
);

var kStyleHotlineNumber = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'NutinoSansReg',
    color: Color(0xFF777777),
    fontWeight: FontWeight.w400);

var kStyleGName = TextStyle(
    fontSize: 10.sp,
    fontFamily: 'NutinoSansReg',
    color: Color(0xFF333333),
    fontWeight: FontWeight.w600);

var kStyleGTime = TextStyle(
    fontSize: 8.sp,
    fontFamily: 'NutinoSansReg',
    color: Color(0xFF3F84FC),
    fontWeight: FontWeight.w600);

var kStyleGReadMore = TextStyle(
    fontSize: 10.sp,
    fontFamily: 'NutinoSansReg',
    color: Color(0xFF324F81),
    fontWeight: FontWeight.w600);

var kStyleO2OMain = TextStyle(
  fontSize: 10.sp,
  fontFamily: 'NutinoSansReg',
  letterSpacing: 0.4,
  color: Color(0xFF324F81),
  fontWeight: FontWeight.w600,
);

var kStyleMusicTxt = TextStyle(
  fontSize: 10.sp,
  fontFamily: 'NutinoSansReg',
  color: Color(0xFF333333),
  fontWeight: FontWeight.w600,
);

var kStyleFPassword = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'NutinoSansReg',
    color: Color(0xFF324F81),
    fontWeight: FontWeight.w600);

var kStyleFPasswordGrey = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'NutinoSansReg',
    color: Color(0xFF777777),
    fontWeight: FontWeight.w400);

var kStyleHintFPassword = TextStyle(
  fontFamily: 'NutinoSansReg',
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: Color(0xffA3A3A3),
);

var kStyleChatMe = TextStyle(
  fontFamily: 'NutinoSansReg',
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: Color(0xffffffff),
);

var kStyleChatDoctor = TextStyle(
  fontFamily: 'NutinoSansReg',
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: Color(0xff000000),
);


/*-------------Doctor Profile---------------------------------*/
var kStyleDoctorList = TextStyle(
  fontFamily: 'Museo Sans Cyrl 500 Regular',
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
  color: Color(0xff222B45),
);

var kStyleDoctorSpeciality = TextStyle(
  fontFamily: 'Museo Sans Cyrl 500 Regular',
  fontSize: 10.sp,
  fontWeight: FontWeight.normal,
  color: Color(0xff6B779A),
);


var kStyleDoctorName = TextStyle(
  fontFamily: 'Museo Sans Cyrl 500 Regular',
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
  color: Color(0xff222B45),
);
