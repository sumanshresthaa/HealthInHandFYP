import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//Textfield used in login/register
class BlueTextFormField extends StatelessWidget {
  BlueTextFormField(
      this.hintText, this.icon, this.nameController, this.validator);

  final nameController;
  final hintText;
  final icon;
  final validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      validator: validator,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(
        fontFamily: 'NutinoSansReg',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xff777777),
      ),
      decoration: InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
                color: Color(0xff3FA5DF)
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
                color: Color(0xff3FA5DF)
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
                color: Colors.red
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'NutinoSansReg',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff777777),
          ),
          contentPadding: EdgeInsets.fromLTRB(8, 8, 16, 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 12),
            child: Image.asset(
              icon, color: Color(0xff3FA5DF),
              width: 22,
            ),
          )),
    );
  }
}


//Phone textfield which will generate number
class BlueTextFormFieldPN extends StatelessWidget {
  BlueTextFormFieldPN(
      this.hintText, this.icon, this.nameController, this.validator);
  final nameController;
  final hintText;
  final icon;
  final validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      controller: nameController,
      validator: validator,
      autocorrect: false,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        fontFamily: 'NutinoSansReg',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xff777777),
      ),
      decoration: InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
                color: Color(0xff3FA5DF),
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xff3FA5DF),
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xff3FA5DF),
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'NutinoSansReg',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff777777),
          ),
          contentPadding: EdgeInsets.fromLTRB(8, 8, 16, 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 12),
            child: Image.asset(
              icon,color: Color(0xff3FA5DF),
              width: 20,
            ),
          )),
    );
  }
}



//Text field for writing the chat message in the text field
class MessageChat extends StatelessWidget {
  MessageChat(
  {this.hintText, this.icon, this.nameController, this.onPress});

  final nameController;
  final hintText;
  final icon;
  final onPress;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(
        fontFamily: 'NutinoSansReg',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xff777777),
      ),
      decoration: InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xff3FA5DF),
            ),
            borderRadius: BorderRadius.circular(0.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xff3FA5DF),
            ),
            borderRadius: BorderRadius.circular(0.0),
          ),

          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'NutinoSansReg',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff777777),
          ),
          contentPadding: EdgeInsets.fromLTRB(8, 8, 16, 8),
          suffixIcon: GestureDetector(
            onTap: onPress,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 12),
              child: Image.asset(
                icon,
                width: 22,
                color: Color(0xff3FA5DF),
              ),
            ),
          )),
    );
  }
}

class SearchTextField extends StatelessWidget {
  SearchTextField({
      this.hintText, this.icon, this.nameController, this.validator});

  final nameController;
  final hintText;
  final icon;
  final validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: nameController,
      validator: validator,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(
        fontFamily: 'NutinoSansReg',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xff777777),
      ),

      decoration: InputDecoration(

          fillColor: Color(0xff6B779A).withOpacity(0.1),
          filled: true,
                 hintText: hintText,
          border: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide.none,
            //borderSide: const BorderSide(),
          ),
          hintStyle: TextStyle(
            fontFamily: 'NutinoSansReg',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff777777),
          ),
          contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 12),
            child: Image.asset(
              icon, color: Color(0xff6B779A),
              width: 18,
            ),
          )),
    );
  }
}


//Text form field is the extracted widget from book appointment
class TextFormFieldForLoginRegister extends StatelessWidget {
  const TextFormFieldForLoginRegister({this.label,this.imageName,this.textFieldDesignType, this.textFieldType, this.controller,this.validator}) : super();
  final String? label;
  final String? imageName;
  final String? textFieldDesignType;
  final String? textFieldType;
  final controller;
  final validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //For adding shadow in the back of text field
          boxShadow: [
            BoxShadow(
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(0, 1),
                color: Color(0xff000000).withOpacity(0.1)
            ),
          ]
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: textFieldType == "phone" ?TextInputType.number : TextInputType.text,
        cursorColor: Colors.black,
        obscureText: textFieldType == "password" ? true : false,
        decoration:  InputDecoration(
          label:  Text(label ?? 'Nothing to Show', style:  TextStyle(
            fontFamily: 'NutinoSansReg',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff777777),
          ),),
          // hintText: 'enter username',
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 26, right: 17),
            child: Image.asset(imageName ?? 'failed', width: 20),
          ),
          filled: true,
          fillColor: Colors.white, //To color the text field do these
          border:  UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: textFieldDesignType == "top"?
            const BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))
                : textFieldDesignType == "bottom" ? BorderRadius.only(bottomLeft: Radius.circular(6.0), bottomRight: const Radius.circular(6.0)) :
            textFieldDesignType == "both" ? BorderRadius.all(Radius.circular(6.0)): BorderRadius.all(Radius.circular(0.0)),
          ),
        ),

      ),
    );
  }
}


//Text form field for making it big with max lines usage: in book appointment


class TextFormFieldEmpty extends StatelessWidget {
  const TextFormFieldEmpty({this.textFieldDesignType, this.maxLines, this.controller }) : super();
  final String? textFieldDesignType;
  final maxLines;
  final controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //For adding shadow in the back of text field
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                spreadRadius: 1,
                offset: Offset(0, 1),
                color: Color(0xff000000).withOpacity(0.1)
            ),
          ]
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        cursorColor: Colors.black,
        decoration:  InputDecoration(
          // hintText: 'enter username',
          filled: true,
          fillColor: Colors.white, //To color the text field do these
          border:  UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius:
            textFieldDesignType == "top"?
            const BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))
                : textFieldDesignType == "bottom" ? BorderRadius.only(bottomLeft: Radius.circular(6.0), bottomRight: const Radius.circular(6.0)) :
            textFieldDesignType == "both" ? BorderRadius.all(Radius.circular(6.0)): BorderRadius.all(const Radius.circular(0.0)),
          ),
        ),

      ),
    );
  }
}

class DatePickerField extends StatelessWidget {
  DatePickerField({required this.controller,required this.date,required this.onPress, this.imageName,this.textFieldDesignType});
  final controller;
  final date;
  final onPress;
  final imageName;
  final textFieldDesignType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          //For adding shadow in the back of text field
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(0, 1),
                  color: Color(0xff000000).withOpacity(0.1)
              ),
            ]
        ),
        child: TextFormField(
          controller: controller,
          enabled: false,
          decoration: InputDecoration(
            label:  Text(date ?? 'Nothing to Show', style:  TextStyle(
              fontFamily: 'NutinoSansReg',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff777777),
            ),),
            // hintText: 'enter username',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 26, right: 17),
              child: Image.asset(imageName ?? 'failed', width: 20),
            ),
            filled: true,
            fillColor: Colors.white, //To color the text field do these
            border:  UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: textFieldDesignType == "top"?
              const BorderRadius.only(topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))
                  : textFieldDesignType == "bottom" ? BorderRadius.only(bottomLeft: Radius.circular(6.0), bottomRight: const Radius.circular(6.0)) :
              textFieldDesignType == "both" ? BorderRadius.all(Radius.circular(6.0)): BorderRadius.all(Radius.circular(0.0)),
            ),
          ),
        ),
      ),
    );
  }
}

