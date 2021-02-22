import 'package:flutter/material.dart';
import 'package:medicare/transfer/profilepage.dart';
import 'package:medicare/widgets/widgets.dart';

class TransferPageMain extends StatefulWidget {
  @override
  _TransferPageMainState createState() => _TransferPageMainState();
}

class _TransferPageMainState extends State<TransferPageMain> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, 'Transfer Page'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: Column(
              children: <Widget>[
          TextFormField(
          validator: (val) {
        return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val)
        ? null
            : "Enter correct Email";
        },
          controller: email,
          style: kTextfieldTextStyle(),
          decoration: kTextfieldInputDecoration('Email'),
        ),
                SizedBox(height: 18,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePageOfAnother(email: email.text,)));
                  },
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey,
                    ),
                    child: Text(
                      "Show",
                      style: kTextfieldTextStyle(),
                    ),
                  ),
                ),
        ],
      ),
    ),
    ),
    );
  }
}
