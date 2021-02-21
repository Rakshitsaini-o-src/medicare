import 'package:flutter/material.dart';
import 'package:medicare/Screens/profile.dart';
import 'package:medicare/helper/sharedpreference.dart';
import 'package:medicare/services/auth.dart';
import 'package:medicare/services/database.dart';
import 'package:medicare/widgets/widgets.dart';

import 'dashboard.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp({this.toggle});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextController = new TextEditingController();
  TextEditingController passwordTextController = new TextEditingController();
  bool _isLoading = false;

  signMeUp(){
    if(formKey.currentState.validate()){
      Map<String,String> userMap = {
        "email": emailTextController.text
      };

      HelperFunctions.saveUserEmailPreferences(emailTextController.text);
      setState(() {
        _isLoading =true;
      });
      authMethods.signUpWithEmail(emailTextController.text, passwordTextController.text)
        .then((value) {
          databaseMethods.uploadUserEmailInfo(userMap,emailTextController.text);
         HelperFunctions.saveUserLoggedInPreferences(true);
         Navigator.pushReplacement(context,
             MaterialPageRoute(builder: (context)=> ProfilePage(email: emailTextController.text)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context,'Sign Up'),
      body: _isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          :SingleChildScrollView(
        child: Container(
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
                  controller: emailTextController,
                  style: kTextfieldTextStyle(),
                  decoration: kTextfieldInputDecoration('Email'),
                ),
                TextFormField(
                  validator: (val) {
                    return val.length > 6 ? null : "Enter password>6";
                  },
                  controller: passwordTextController,
                  style: kTextfieldTextStyle(),
                  decoration: kTextfieldInputDecoration('Password'),
                  autocorrect: false,
                  enableSuggestions: false,
                  obscureText: true,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: Text(
                      "Forget Password?",
                      style: kTextfieldTextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    signMeUp();
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
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF9E9E9E),
                          const Color(0xFF455a64),
                        ],
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: kTextfieldTextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have a Account? ",
                      style: kTextfieldTextStyle(),
                    ),
                    GestureDetector(
                      onTap: widget.toggle,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Login Now",
                          style: kTextfieldTextStyle().copyWith(
                              decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
