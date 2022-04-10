import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Screens/BookAppointment/receipt.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import '../../../Models/view_appointment.dart';
import '../../../Network/api_links.dart';
import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';

class AppointmentDetails extends StatefulWidget {
  AppointmentDetails({this.index});
  final index;


  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {

  late var token = Provider.of<DataProvider>(context, listen: false).tokenValue;

  Future<ViewAppointment?>? _appointmentDetails;

  Future<ViewAppointment>? getApiData() async {
    var appointmentData = await ApiData().getAppointmentDetails(token);
    print(appointmentData);
    return appointmentData;


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();
    _appointmentDetails = getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F7FF),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFFFFF),
        title: Text('Appointment Details', style: kStyleHomeWelcome.copyWith(color: Color(0xff324F81)),),
        leading: GestureDetector(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back, color: Color(0xff324F81),)),
        centerTitle: true,


      ),
      body: FutureBuilder<ViewAppointment?>(
        future: _appointmentDetails,
        builder: (context, snapshot) {
          var initial = snapshot.data?.appointments?[widget.index];
          var forSeparation = initial?.datetime;
          //var separateDateTime = forSeparation?.toString().substring(
            //forSeparation.toString().indexOf(' '), 6 );
          var time = DateFormat.Hm().format(forSeparation!);
          var date = DateFormat.yMMMMd().format(forSeparation);
          var hospitalName = initial?.hospitalName;
          var address = initial?.optional2;
          var name = initial?.name;
          var age = initial?.age;
          var sex = initial?.gender;
         // var time = initial?.datetime;
          var doctor = initial?.doctorName;
          var patientId = initial?.optional1;
          var phone = initial?.phone;
          if (!snapshot.hasData) {
            return Container(
              height: 800,
              child: Shimmer.fromColors(
                direction: ShimmerDirection.ttb,
                period: const Duration(milliseconds: 8000),
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(16),
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black,
                        ),
                      );
                    }),
                baseColor: Color(0xFFE5E4E2),
                highlightColor: Color(0xFFD6D6D6),
              ),
            );
          }
          else{
          return Column(
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
                        AllDetails(title: 'Address', details: '$address',),
                        AllDetails(title: 'Appointment date', details: '$date',),
                        AllDetails(title: 'Time', details: '$time',),
                        AllDetails(title: 'Doctor', details: '$doctor',),
                        AllDetails(title: 'Patient Id', details: '$patientId',),




                      ],
                    ),
                  ),
                ),
              ),
            ],
          );}
        }
      ),

    );
  }
}
