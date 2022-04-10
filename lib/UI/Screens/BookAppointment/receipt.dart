import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/BottomNavigations/bottom_navigation_hiv.dart';

import '../../../Textstyle/constraints.dart';
import '../../Extracted Widgets/buttons.dart';

class Receipt extends StatelessWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F7FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFFFFF),
        title: Text('Receipt', style: kStyleHomeWelcome.copyWith(color: Color(0xff324F81)),),
        leading: Icon(Icons.arrow_back, color: Color(0xff324F81),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/successful_appointment.png', height: 200,),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue[100]!.withOpacity(0.5),
                    blurRadius: 4.0, // soften the shadow
                    offset: Offset(
                      2.0, // Move to right 10  horizontally
                      2.0, // Move to bottom 10 Vertically
                    ),
                  ),
                ],


              ),
              child:Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0,top: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    AllDetails(title: 'Name', details: 'Suman Shrestha',),
                    AllDetails(title: 'Age', details: 'Suman Shrestha',),
                    AllDetails(title: 'Sex', details: 'Suman Shrestha',),
                    AllDetails(title: 'Address', details: 'Suman Shrestha',),
                    AllDetails(title: 'Appointment date', details: 'Suman Shsrestha',),
                    AllDetails(title: 'Time', details: 'Suman Shrestha',),
                    AllDetails(title: 'Doctor', details: 'Suman Shrestha',),
                    AllDetails(title: 'Id number', details: 'Suman Shrestha',),




                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),

            BlueButton('Go to Home', (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return BottomNavigationHiv();
              }));
            })

          ],
        ),
      ),

    );
  }
}

class AllDetails extends StatelessWidget {
AllDetails({this.title, this.details});
final title;
final details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text('$title: '),
          Text('$details')
        ],
      ),
    );
  }
}
