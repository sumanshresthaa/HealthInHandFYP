import 'package:flutter/material.dart';
import 'package:health_in_hand/Models/view_appointment.dart';
import 'package:health_in_hand/Network/NetworkHelper.dart';
import 'package:health_in_hand/Network/api_links.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../Textstyle/constraints.dart';
import '../../../ViewModel/changenotifier.dart';
import 'appointment_details.dart';


class ViewAppointments extends StatefulWidget {
  const ViewAppointments({Key? key}) : super(key: key);

  @override
  State<ViewAppointments> createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewAppointments> {
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
        title: Text('View Appointments', style: kStyleHomeWelcome.copyWith(color: Color(0xff324F81)),),
        leading: GestureDetector( onTap: (){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back, color: Color(0xff324F81),)),
        centerTitle: true,
      ),
      body: FutureBuilder<ViewAppointment?>(
          future: _appointmentDetails,
        builder: (context, snapshot) {
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
          return ListView.builder(
            itemCount: snapshot.data?.appointments?.length,
            itemBuilder: (context, int index) {
              var initial =  snapshot.data?.appointments?[index];
              var hospitalName = initial?.hospitalName;
              var address = initial?.optional1;
              var doctorName = initial?.doctorName;
              var phoneNum = initial?.phone;
              var sex = initial?.gender;
              var patientId = initial?.optional2;
              var age = initial?.age;
              var name = initial?.name;
              var date = initial?.datetime;



              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AppointmentDetails(hospitalName: hospitalName, address: address, doctor: doctorName, phone: phoneNum, sex: sex, patientId: patientId, age: age, name: name, date: date, time: "20:00", );
                    }));
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue[100]!.withOpacity(0.5),
                              blurRadius: 5.0, // soften the shadow
                              offset: Offset(
                                2.0, // Move to right 10  horizontally
                                2.0, // Move to bottom 10 Vertically
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$hospitalName', style: kStyleTime.copyWith( color: Color(0xff324F81), fontSize: 16.sp),),
                              SizedBox(height: 5,),
                              IconAndDetails(details: '$address', icon: Icons.location_on_outlined),
                              SizedBox(height: 5,),
                              IconAndDetails(details: 'Dr. $doctorName', icon: Icons.person),
                              SizedBox(height: 5,),
                              IconAndDetails(details: '$phoneNum', icon: Icons.phone_outlined),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0),bottomRight: Radius.circular(8.0)),
                          color:  Color(0xff3FA5DF),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue[100]!.withOpacity(0.5),
                              blurRadius: 5.0, // soften the shadow
                              offset: Offset(
                                2.0, // Move to right 10  horizontally
                                2.0, // Move to bottom 10 Vertically
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text('View Details', style: kStyleTimeComment.copyWith(color: Colors.white),),
                            Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}

class IconAndDetails extends StatelessWidget {
  IconAndDetails({this.icon, this.details});
  final icon;
  final details;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 10,),
        Text('$details', style: kStyleTimeComment,),
      ],
    );
  }
}
