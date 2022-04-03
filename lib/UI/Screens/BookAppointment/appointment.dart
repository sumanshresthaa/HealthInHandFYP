import 'package:flutter/material.dart';
import 'package:health_in_hand/Textstyle/constraints.dart';

import '../../Extracted Widgets/bluetextfield.dart';
import '../../Extracted Widgets/buttons.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),

      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: Color(0xff3FA5DF))
        ),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: (){
            final isLastStep = currentStep == getSteps().length - 1;
            if(isLastStep){
              //Sending data to server Create Appointment
              print('api called');
            }
            setState(() {
              currentStep += 1;
            });
          },
          onStepCancel: currentStep == 0 ? null : (){
            setState(() {
              currentStep -= 1;
            });
          },
          onStepTapped: (step) => setState(() {
            currentStep = step;
          }),
          controlsBuilder: (BuildContext context, ControlsDetails details){
            final isLastStep = currentStep == getSteps().length - 1;

            return Container(
              child: Row(
                children: [
                  if(currentStep!= 0)
                    AppointmentButton( text: 'Previous', onPress: details.onStepCancel),
                  AppointmentButton(text: isLastStep ? 'Confirm' : 'Next' , onPress: details.onStepContinue,),
                /*  TextButton(onPressed:  details.onStepContinue, child: Text(isLastStep ? 'Confirm' : 'Next')),*/

                ],
              ),
            );
          },

        ),
      ),

    );
  }


  List<Step> getSteps(){
    return [
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
      title: Text('Account'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name', style: kStyleContent.copyWith(color: Color(0xff000000)),),
          SizedBox(height: 10,),
          TextFormFieldForLoginRegister( label: 'Full Name',
            imageName: 'assets/formIcons/personIcon.png',),
          SizedBox(height: 20,),
          Text('Address', style: kStyleContent.copyWith(color: Color(0xff000000)),),
          SizedBox(height: 10,),

          TextFormFieldForLoginRegister( label: 'Address',
            imageName: 'assets/formIcons/mapIcon.png',),
          SizedBox(height: 20,),
          Text('Age', style: kStyleContent.copyWith(color: Color(0xff000000)),),
          SizedBox(height: 10,),

          TextFormFieldForLoginRegister( label: 'Age',
            imageName: 'assets/formIcons/mapIcon.png',),

          SizedBox(height: 20,),
          Text('Email', style: kStyleContent.copyWith(color: Color(0xff000000)),),
          SizedBox(height: 10,),

          TextFormFieldForLoginRegister( label: 'Email',
            imageName: 'assets/formIcons/messageLogin.png',),
          SizedBox(height: 30,)
        ],
      )

    ),
    Step(
      state: currentStep > 1? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text('Address'),
        content: Container()

    ),
    Step(
        isActive: currentStep >= 2 ,
        title: Text('Complete'),
         content: Container()

    ),];
  }
}
