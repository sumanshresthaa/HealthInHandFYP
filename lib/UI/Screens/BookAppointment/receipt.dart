import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/BottomNavigations/bottom_navigation_arthritis.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../Textstyle/constraints.dart';
import '../../Extracted Widgets/buttons.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Receipt extends StatelessWidget {
 Receipt({this.name, this.age, this.gender, this.date, this.time, this.doctorName, this.hospital, this.patientId, this.qr});
 final name, age, gender, date, time, doctorName, hospital, patientId, qr;
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
        child: ListView(
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

                    AllDetails(title: 'Name', details: '$name',),
                    AllDetails(title: 'Age', details: '$age',),
                    AllDetails(title: 'Sex', details: '$gender',),
                    AllDetails(title: 'Appointment date', details: '$date',),
                    AllDetails(title: 'Time', details: '$time',),
                    AllDetails(title: 'Health Center', details: '$hospital',),

                    AllDetails(title: 'Doctor Assigned', details: 'Dr. $doctorName',),
                    AllDetails(title: 'Id number', details: '$patientId',),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          children: [
                            Text('Find QR in View Appointment '),
                            TextButton(child: Text('Download pdf'), onPressed: ()  {
                              final pdfFile = pw.Document();
                              pdfFile.addPage(pw.Page(
                                pageFormat: PdfPageFormat.a4,
                                build: (pw.Context context){
                                  return pw.Center(
                                    child: pw.Text('Hello World'),
                                  );
                                }
                              ));

                            },)
                          ],
                        ),
                        QrImage(
                          data: qr,
                          size: 100,
                          backgroundColor: Colors.white,

                        ),
                      ],
                    ),




                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),

            BlueButton('Go to Home', (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return BottomNavigationArthritis();
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
