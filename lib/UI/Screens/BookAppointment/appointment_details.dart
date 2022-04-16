import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Screens/BookAppointment/pdf_api.dart';
import 'package:health_in_hand/UI/Screens/BookAppointment/receipt.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../Models/view_appointment.dart';
import '../../../Network/api_links.dart';
import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';

class AppointmentDetails extends StatelessWidget {
  AppointmentDetails({ this.hospitalName, this.sex, this.phone, this.name, this.age, this.qr, this.date, this.time, this.doctor, this.patientId});
  final hospitalName, phone, name, age, qr, date, time, doctor, patientId, sex ;









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F7FF),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFFFFF),
        title: Text('Appointment Details', style: kStyleHomeWelcome.copyWith(color: Color(0xff324F81)),),
        leading: GestureDetector(
            onTap:(){Navigator.pop(context);
        },child: Icon(Icons.arrow_back, color: Color(0xff324F81),)),
        centerTitle: true,


      ),
      body: ListView(
        shrinkWrap: true,
        children: [

          Column(
                  children: [
                    SizedBox(height: 12,),
                    Text('$hospitalName', style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 4,),
                    Text('Maharajgunj, Kathmandu', style: TextStyle(
                        fontSize: 12.sp
                    ),),
                    SizedBox(height: 4,),

                    Text('$phone', style: TextStyle(
                        fontSize: 12.sp
                    ),),
                    SizedBox(height: 12,),


                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
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
                              AllDetails(title: 'Sex', details: '$sex',),
                              AllDetails(title: 'Appointment date', details: '$date',),
                              AllDetails(title: 'Time', details: '$time',),
                              AllDetails(title: 'Doctor', details: '$doctor',),
                              AllDetails(title: 'Patient Id', details: '$patientId',),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Column(
                                    children: [
                                      TextButton(child: Text('Download pdf'), onPressed: ()  async {
                                       /*
                                        final pdfFile = pw.Document();
                                        pdfFile.addPage(pw.Page(
                                            pageFormat: PdfPageFormat.a4,
                                            build: (pw.Context context){
                                              return pw.Center(
                                                child: pw.Text('Hello World'),
                                              );
                                            }
                                        ));*/
                                        final pdfFile = await PdfApi.generateCenteredText('Sample Text');

                                        PdfApi.openFile(pdfFile);

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
                    ),
                  ],
                ),
    ],)








    );
  }
}

