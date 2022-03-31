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
                color: Color(0xff0D5D40)
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
                color: Color(0xff0D5D40)
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
                color: Color(0xff0D5D40)
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
              icon, color: Color(0xff0D5D40),
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
                color: Color(0xff0D5D40),
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xff0D5D40),
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
              color: Color(0xff0D5D40),
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
              icon,color: Color(0xff0D5D40),
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
              color: Color(0xff0D5D40),
            ),
            borderRadius: BorderRadius.circular(0.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xff0D5D40),
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
                color: Color(0xff0D5D40),
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