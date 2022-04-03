import 'package:flutter/material.dart';
import 'package:health_in_hand/UI/Chatroom/chat_room.dart';
import 'package:health_in_hand/UI/Login/login.dart';
import 'package:sizer/sizer.dart';
import '../../Textstyle/constraints.dart';
import 'BookAppointment/appointment.dart';
import 'Doctors/doctor_list.dart';
class HomeDesignAppBar extends StatelessWidget {
  const HomeDesignAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text('Welcome, Suman', style: kStyleHomeWelcome),

                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF3F7FF),
                      borderRadius: BorderRadius.all(Radius.circular(
                          10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 3,
                          offset: Offset(
                              0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                          'assets/calendariconhome.png', height: 22),
                    ),
                  ),
                  SizedBox(width: 8,),
                  Icon(Icons.more_vert)
                ],
              )

            ],
          ),
        ),
      ],
    );
  }
}

class HomeDesign extends StatelessWidget {
HomeDesign({this.imageURL, this.specialities, this.type});
final imageURL;
final specialities;
final type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return BookAppointment();
            }));
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(
                    12.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.2),
                    blurRadius: 5,
                    offset: Offset(
                        0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(
                '$imageURL',)),
        ),
        /*CarouselSlider.builder(
                      itemCount: carouselHiv.length,
                      itemBuilder: (context, index, realIndex){
                        final hivImage = carouselHiv[index];
                        return buildImage(hivImage, index);
                      },
                      options: CarouselOptions(height:200,
                          viewportFraction: 1,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          }
                      )),*/
        // Center(child: buildIndicator()),
        //SizedBox(height: 30,),
        SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return DoctorList();
            }));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff979797).withOpacity(0.08),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(type == 'arthritis' ? 'Joint Related Problems? ' : 'Lungs related problem',
                        style: kStyleHomeWelcome.copyWith(
                          letterSpacing: 0,),),
                      Text('Find suitable specialist here ',
                        style: kStyleMuseoTextContent,)
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 3,
                          offset: Offset(
                              0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/rightarrow.png', height: 14,),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text('Specialty 😷', style: kStyleTime.copyWith(
            color: Color(0xff222B45)),),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: specialities.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LoginPage(page: ChatRoom(), isFromProfile: false,);
                    }));},

                    child: Container(


                      decoration: BoxDecoration(
                        color: Color(0xffF8F8FA),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 2,
                            offset: Offset(5.0, 5.0),

                          ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0),

                      width: 100.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                                'assets/dnaicon.png', height: 38),

                          ),

                          Column(
                            children: [
                              Text('${specialities[index]}',
                                style: kStyleHomeWelcome,),
                              Text('1000 doctors',
                                style: kStyleMuseoTextContent
                                    .copyWith(fontSize: 10.sp),),

                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
        SizedBox(
          height: 15,
        ),

      ],
    );
  }
}
