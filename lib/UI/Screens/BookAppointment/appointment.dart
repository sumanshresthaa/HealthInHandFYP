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
  TimeOfDay selectedTime = TimeOfDay.now();
  final selectDate = TextEditingController();
  var selectTime= TextEditingController();
  TextEditingController name= TextEditingController();
  TextEditingController address= TextEditingController();

  TextEditingController age= TextEditingController();

  TextEditingController phone= TextEditingController();

  TextEditingController email= TextEditingController();
  TextEditingController problem= TextEditingController();






  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff3FA5DF),
        title: Text('Book Appointment', style: kStyleHomeWelcome.copyWith(color: Colors.white),),
        leading: Icon(Icons.arrow_back, color: Colors.white,),


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
              //Sending data to server Create Appointmento
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

                 currentStep ==0 ? SizedBox(width: 0,): SizedBox(width: 20,),
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
      title: Text('Personal'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name', style: kStyleContent.copyWith(color: Color(0xff000000)),),
          SizedBox(height: 10,),
          TextFormFieldForLoginRegister( label: 'Full Name',
            imageName: 'assets/formIcons/personIcon.png', textFieldDesignType: 'both', controller: name,),
          SizedBox(height: 20,),
          Text('Address', style: kStyleContent.copyWith(color: Color(0xff000000)),),
          SizedBox(height: 10,),

          TextFormFieldForLoginRegister( label: 'Address',
            imageName: 'assets/formIcons/mapIcon.png', textFieldDesignType: 'both', controller: address),
          SizedBox(height: 20,),
          Text('Age', style: kStyleContent.copyWith(color: Color(0xff000000)),),
          SizedBox(height: 10,),

          TextFormFieldForLoginRegister( label: 'Age',
            imageName: 'assets/formIcons/mapIcon.png', textFieldDesignType: 'both', controller: age),

          SizedBox(height: 20,),
          Text('Phone and Email', style: kStyleContent.copyWith(color: Color(0xff000000)),),
          SizedBox(height: 10,),
          TextFormFieldForLoginRegister( label: 'Phone',
            imageName: 'assets/formIcons/phoneIcon.png', textFieldDesignType: 'top',textFieldType: 'phone', controller: phone),

          TextFormFieldForLoginRegister( label: 'Email',
            imageName: 'assets/formIcons/messageLogin.png', textFieldDesignType: 'bottom',  controller: email),
          SizedBox(height: 30,)
        ],
      )

    ),
    Step(
      state: currentStep > 1? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text('Address'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date And Time', style: kStyleContent.copyWith(color: Color(0xff000000)),),
            SizedBox(height: 10,),
            DatePickerField(imageName: 'assets/formIcons/calendar.png',  textFieldDesignType: 'top',controller: selectDate,date: selectDate.text,onPress: ()async{
              DateTime? _selectedDateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1990),
                lastDate: DateTime(2040),
                initialDatePickerMode: DatePickerMode.day,
              );
              setState(() {
                selectDate.text = _selectedDateTime.toString().substring(0, _selectedDateTime.toString().indexOf(' '));
              });
            },),
            DatePickerField(imageName: 'assets/formIcons/clock.png',  textFieldDesignType: 'bottom',controller: selectTime,date: selectTime.text,onPress: ()async{
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: selectedTime,
                initialEntryMode: TimePickerEntryMode.dial,
              );
              if(timeOfDay != null && timeOfDay != selectedTime)
              {
                setState(() {
                  selectedTime = timeOfDay;
                  selectTime.text = selectedTime.toString();
                });
              }
            },),

           /* TextFormFieldForLoginRegister( label: 'Select your preferable date',
              imageName: 'assets/formIcons/calendar.png', textFieldDesignType: 'top',),
            TextFormFieldForLoginRegister( label: 'Your preferable time',
              imageName: 'assets/formIcons/clock.png', textFieldDesignType: 'bottom',),*/
            SizedBox(height: 30,),
            Text('Select Clinic', style: kStyleContent.copyWith(color: Color(0xff000000)),),
            SizedBox(height: 10,),


            getDropdownHospital(),
            SizedBox(height: 30,),

            Text('Describe your problem', style: kStyleContent.copyWith(color: Color(0xff000000)),),
            SizedBox(height: 10,),
            TextFormFieldEmpty(maxLines: 5, textFieldDesignType: 'both',controller: problem),
            SizedBox(height: 30,),




          ],
        )

    ),
    Step(
        isActive: currentStep >= 2 ,
        title: Text('Complete'),
         content: Column(
           children: [
             RecheckResult(title: 'Name',name: name.text),
             RecheckResult(title: 'Address',name: address.text),
             RecheckResult(title: 'Age',name: age.text),
             RecheckResult(title: 'Phone',name: phone.text),
             RecheckResult(title: 'Email',name: email.text),
             RecheckResult(title: 'Date',name: selectDate.text),
             RecheckResult(title: 'Time',name: selectTime.text),
             RecheckResult(title: 'Problem',name: problem.text),
             SizedBox(height: 50,)
          ],
         )

    ),];
  }
  String currentType = 'Sahara Clinic';
  var types = ['Sahara Clinic','Basundhara Poly Clinic', 'Meridian Health Care'];
  DropdownButtonFormField<String> getDropdownHospital(){
    List<DropdownMenuItem<String>> dropDownItems = [];

    for(String type in types){
      var newItem = DropdownMenuItem(
          child: Text('${type[0].toUpperCase()}${type.substring(1)}', style: TextStyle(color: Colors.grey)),
          value: type);
      dropDownItems.add(newItem);
    }
    return DropdownButtonFormField(

      dropdownColor: Colors.white,
      value: currentType,
      items: dropDownItems,

      onChanged: (value){
        setState(() {
          currentType = value!;

        });
      },
    decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade100, width: 2),
    borderRadius: BorderRadius.circular(4),

    ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      filled: true,
      fillColor: Colors.white,
      focusedBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    );
  }
}

class RecheckResult extends StatelessWidget {
RecheckResult({this.name, this.title});
final title;
final name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title: ', style: kStyleTime,),
        SizedBox(height: 20,),
        Text('$name', style: kStyleHomeWelcome.copyWith(fontSize: 14),),
      ],
    );
  }
}
