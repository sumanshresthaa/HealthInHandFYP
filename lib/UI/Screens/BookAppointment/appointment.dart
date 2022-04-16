import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:flutter/material.dart';
import 'package:health_in_hand/Network/NetworkHelper.dart';
import 'package:health_in_hand/Textstyle/constraints.dart';
import 'package:health_in_hand/UI/Screens/BookAppointment/receipt.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../ViewModel/changenotifier.dart';
import '../../Extracted Widgets/bluetextfield.dart';
import '../../Extracted Widgets/buttons.dart';
import '../../Extracted Widgets/snackbar.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  TimeOfDay selectedTime = TimeOfDay.now();
  final selectDate = TextEditingController();
  var selectTime= TextEditingController();
  var dateChose;
  int? _value = 0;
  String? gender;
  String? hospital;
  TextEditingController name= TextEditingController();
  TextEditingController address= TextEditingController();
  TextEditingController age= TextEditingController();
  TextEditingController phone= TextEditingController();
  TextEditingController email= TextEditingController();
  TextEditingController problem= TextEditingController();
  late var token = Provider.of<DataProvider>(context, listen: false).tokenValue;
  List _selectedPaymentT = [];
  List images = [
    'assets/cash.png',
    'assets/esewa.png',
  ];
  List nameList = [
    'Cash',
    'Esewa',
  ];

  var doctors = [
    'Suyash Ghimire',
    'Ojas Thapa',
    'Prashansa Dhungana',
    'Rebicca Pradhan'
  ];


  var patientId;
  random() {
    patientId =  1000 + Random().nextInt(10000 - 1000);
  }


  ESewaPnp? _esewaPnp;
  ESewaConfiguration? _configuration;
  int currentStep = 0;

  String? doctorName;

  selectRandomDoctor(){
Random random = Random();
  int doctorNumber = random.nextInt(4);
 doctorName = doctors[doctorNumber];
 print(doctorName);
}


_initPayment(String product) async {
  _configuration = ESewaConfiguration(
    clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
    secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
    environment: ESewaConfiguration.ENVIRONMENT_TEST,
  );
  _esewaPnp = ESewaPnp(configuration: _configuration!);

  ESewaPayment _payment =ESewaPayment(amount: 500.0,
       productName: 'Appointments',
      productID: patientId.toString(),
      callBackURL: 'www.esewa.com');


  try {
    final _res = await _esewaPnp?.initPayment(payment: _payment);
    showSnackBar(
      context,
      "Success!",
      Color(0xff3FA5DF),
      Icons.info,
      "${_res?.message}",
    );
    // Handle success
  } on ESewaPaymentException catch(e) {
    print(e);
    // Handle error
  }

}


  @override
  void initState() {
    // TODO: implement initState
    selectRandomDoctor();
    random();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F7FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFFFFF),
        title: Text('Book Appointment', style: kStyleHomeWelcome.copyWith(color: Color(0xff324F81)),),
        leading: Icon(Icons.arrow_back, color: Color(0xff324F81),),
        centerTitle: true,


      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: Color(0xff3FA5DF))
        ),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () async {

            final isLastStep = currentStep == getSteps().length - 1;
            if(isLastStep) {
              //Sending data to server Create Appointment
             if (name.text.isNotEmpty &&
                 age.text.isNotEmpty &&
                 phone.text.isNotEmpty &&
                 problem.text.isNotEmpty &&
                 selectDate.text.isNotEmpty &&
                 selectTime.text.isNotEmpty &&
                 _value != 0 &&
                 currentType != 'Select Hospital'
                  && _selectedPaymentT.isNotEmpty
                                  ) {
               NetworkHelper networkHelper = NetworkHelper();
               await  networkHelper.createAppointment(name.text, age.text, gender!, dateChose.toString() + " " + selectTime.text, '$doctorName' , '$hospital', problem.text, phone.text, patientId.toString(), 'verified user of health in hand of id ${patientId.toString()}', token);
                print('api called');
               Navigator.of(context).pushAndRemoveUntil(
                 MaterialPageRoute(
                   /*            settings: RouteSettings(name: '/1'),*/
                   builder: (context) =>  Receipt(name:name.text, age:age.text, gender:gender, date:dateChose.toString(), time:selectTime.text, doctorName:doctorName,hospital:hospital,patientId:patientId.toString(), qr:'verified user of health in hand of id ${patientId.toString()}' )

                 ),
                 ModalRoute.withName('/'),
               );
             }
             else {
               print('failed');
               showDialog(
                 context: context,
                 builder: (BuildContext context) {
                   return AlertDialog(
                     title: const Text("Alert"),
                     content: const Text("Please fill up all the fields"),
                     actions: [
                       TextButton(
                         child: const Text("OK"),
                         onPressed: () {
                           Navigator.pop(context);
                         },
                       )
                     ],
                   );
                 },
               );
             }

            }else{
              setState(() {
                currentStep += 1;
              });
            }

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
          Text(
            'Gender',
            style:  kStyleContent.copyWith(color: Color(0xff000000))
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio(
                    activeColor: Colors.black38,
                    value: 1,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = 1;
                        gender = 'Male';
                      });
                    },
                  ),
                  Text(
                    'Male',
                    style: kStyleHome,
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Radio(
                    activeColor: Colors.black38,
                    value: 2,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = 2;
                        gender = 'Female';
                      });
                    },
                  ),
                  Text(
                    'Female',
                    style: kStyleHome,
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Radio(
                    activeColor: Colors.black38,
                    value: 3,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = 3;
                        gender = 'Others';
                      });
                    },
                  ),
                  Text(
                    'Others',
                    style: kStyleHome,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30,),


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
                dateChose = DateFormat('yyyy-MM-dd').format(_selectedDateTime!);

                print(dateChose);
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
                  DateTime parsedTime = DateFormat.jm()
                      .parse(timeOfDay .format(context).toString());
                  String formattedTime =
                  DateFormat('HH:mm:ss').format(parsedTime);
                  selectTime.text = formattedTime;
                  print("select ${formattedTime}");
                  print(
                      'sect ${dateChose.toString() + " " + selectTime.text}');

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
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             RecheckResult(title: 'Name',name: name.text),
             RecheckResult(title: 'Address',name: address.text),
             RecheckResult(title: 'Age',name: age.text),
             RecheckResult(title: 'Phone',name: phone.text),
             RecheckResult(title: 'Email',name: email.text),
             RecheckResult(title: 'Date',name: selectDate.text),
             RecheckResult(title: 'Time',name: selectTime.text),
             RecheckResult(title: 'Problem',name: problem.text),
             //RecheckResult(title: 'Doctor Assigned',name: doctorName),
             SizedBox(height: 40,),

             Text(
               'Payment Options:',
               style: kStyleTime,
             ),
             SizedBox(
               height: MediaQuery.of(context).size.height * 0.20,
               child: ListView.builder(
                   padding: EdgeInsets.zero,
                   itemCount: 2,
                   itemBuilder: (context, i) {
                     final _isSelected = _selectedPaymentT.contains(i);
                     var _isSelectedPay = nameList[i];
                     return PaymentOptions(
                       icon: images[i],
                       name: nameList[i],
                       onTap: () {
                         setState(
                               () {
                             if (_isSelected) {
                               _selectedPaymentT.remove(i);
                             } else if (_selectedPaymentT.isNotEmpty) {
                               _selectedPaymentT.clear();
                               _selectedPaymentT.add(i);
                             } else {
                               _selectedPaymentT.add(i);
                             }
                           },
                         );

                         if (_selectedPaymentT.contains(1)) {
                           _initPayment(_isSelectedPay);
                         }
                       },
                       isSelected: _isSelected,
                     );
                   }),
             ),


             SizedBox(height: 50,)
          ],
         )

    ),];
  }
  String currentType = 'Select Hospital';
  var types = [
    'Select Hospital',
    'T.U. Teaching Hospital',
    'Bir Hospital',
    'Norvic International Hospital',
    'Patan Hospital',
    'Kathmandu Model Hospital',
  ];
  DropdownButtonFormField<String> getDropdownHospital() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String type in types) {
      var newItem = DropdownMenuItem(
          child: Text(
            '${type[0].toUpperCase()}${type.substring(1)}',
            style: kStyleHome.copyWith(color: Colors.grey.shade600),
          ),
          value: type);
      dropDownItems.add(newItem);
    }
    return DropdownButtonFormField(
      dropdownColor: Colors.white,
      style: kStyleHome.copyWith(color: Colors.black38),
      value: currentType,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          currentType = value!;
          hospital = currentType;
          print(currentType);
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(

        ),
        enabledBorder: OutlineInputBorder(
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

class PaymentOptions extends StatelessWidget {
  PaymentOptions(
      {required this.icon,
        required this.name,
        required this.onTap,
        required this.isSelected});

  final icon;
  final name;
  final onTap;
  final isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
        BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        blurRadius: 3,
        offset: Offset(
            0, 2), // changes position of shadow
      ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 23,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: kStyleHome,
                  ),
                  Icon(
                    isSelected ? Icons.check_circle : Icons.circle,
                    color: isSelected ? Colors.blue : Color(0xFFA3A3A3),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
