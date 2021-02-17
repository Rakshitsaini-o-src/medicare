import 'package:flutter/material.dart';

TextStyle kTextfieldTextStyle(){
  return TextStyle(
    color: Color(0xFF212121),
    fontSize: 18
  );
}

InputDecoration kTextfieldInputDecoration(String hintText){
  return InputDecoration(
    hintText: hintText,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0XFF3F51B5),
        width: 2,
      )
    )
  );
}
Widget appBarMain(BuildContext context,String title){
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.green,
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 15,
      ),
    ),
  );
}