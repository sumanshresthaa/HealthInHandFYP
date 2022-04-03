import 'dart:convert';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import '../../../Models/get_details_of_doctor.dart';
import '../../../Textstyle/constraints.dart';
import '../../Extracted Widgets/bluetextfield.dart';
import 'doctor_profile.dart';
class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  TextEditingController textEditingController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<DetailsOfDoctor>? _doctorList;

  Future<DetailsOfDoctor> getApiData() async {
    var cacheData = await APICacheManager().getCacheData("doctor_list");
    var jsonMap = jsonDecode(cacheData.syncData);
    print("cache: hit");
    return DetailsOfDoctor.fromJson(jsonMap);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _doctorList = getApiData();
  }


  var doctorImage = [
    'assets/suyash.jpg',
    'assets/prashansa.jpg',
    'assets/ojas.jpg',
    'assets/prashansa.jpg',

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      scaffoldKey.currentState!.openDrawer();
                    },
                      child: Image.asset('assets/drawer.png', height: 14,)),
                  Text('Doctors', style: kStyleHomeWelcome),
                  Container(width: 14,)

                ],
              ),
              SizedBox(
                height: 28,
              ),
              SearchTextField(hintText: 'Search for doctors', validator: null,nameController: textEditingController, icon: 'assets/search.png',),

              ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 10,),
                  FutureBuilder<DetailsOfDoctor>(
                      future: _doctorList,
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return GridView.builder(
                            physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,

                            ),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              var detail = snapshot.data!.data!.doctorDetails![index];
                              var details = snapshot.data!.data!.doctorDetails;

                              var doctorName = detail!.name;
                              var speciality = detail.speciality;
                              var rating = detail.ratings;

                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return DoctorProfile(index: index, details: details, doctorImage: doctorImage[index]);
                                  }));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DoctorDetails(doctorName: doctorName, speciality: speciality, rating: rating,image: doctorImage, index: index),
                                ),
                              );


                            },
                          );
                        }
                        return CircularProgressIndicator.adaptive();
                      })
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}

class DoctorDetails extends StatelessWidget {
 DoctorDetails({this.doctorName, this.speciality, this.rating, this.image, this.index});
 final doctorName;
 final speciality;
 final rating;
 final image;
 final index;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color:
            Colors.grey.withOpacity(0.05),
            spreadRadius: 10,
            blurRadius: 4,
            offset: Offset(0,
                -2), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(image[index]),
                    fit: BoxFit.cover
                ),
              ),
            ),
            Column(
              children: [
                FittedBox(child: Text('Dr. $doctorName', style: kStyleDoctorList,)),
                Text('$speciality', style: kStyleDoctorSpeciality,),
                Text('⭐ $rating', style: kStyleDoctorSpeciality,)
              ],
            ),

          ],
        ),
      ),
    );
  }
}
