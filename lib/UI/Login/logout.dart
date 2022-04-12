import 'package:flutter/material.dart';
import 'package:health_in_hand/Textstyle/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Extracted Widgets/snackbar.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class LogoutDialog{

  showDialogLogout(context){
    showDialog(
      barrierColor: Colors.blueAccent.withOpacity(0.3),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
          title: Text('Sign-out from user?', style: kStyleHome.copyWith(fontSize: 15.sp),),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () async {
                Navigator.pop(context);

                showDialogLogoutCircularIndicator(context);

                showSnackBar(
                  context,
                  "Successful",
                  Colors.blue,
                  Icons.info,
                  "Sign-out successful",
                );

              }, child: Text('Yes', style: kStyleMuseoText.copyWith(color: Colors.blue),)),
              SizedBox(
                width: 12,
              ),
              TextButton(onPressed: (){}, child: Text('No',style: kStyleMuseoText.copyWith(color: Colors.blue),)),

            ],
          )),
    );
  }


  showDialogLogoutCircularIndicator(context) async {
    showDialog(
      barrierColor: Colors.blueAccent.withOpacity(0.3),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Loading...'),
        content: Row(
          children: [
            CircularProgressIndicator(
              color: Colors.blue,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text('Signing out'),
            )
          ],
        ),),

    );
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //await preferences.remove('ISLOGGEDIN');
    await preferences.clear();
    Navigator.pop(context);
  }



}