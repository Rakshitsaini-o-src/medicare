import 'package:flutter/material.dart';
import 'package:medicare/Screens/dashboard.dart';
import 'package:medicare/helper/sharedpreference.dart';
import 'package:medicare/services/auth.dart';
import 'package:medicare/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  TextEditingController emailTextController = new TextEditingController();
  TextEditingController passwordTextController = new TextEditingController();
  bool _isLoading = false;


  signMeIn() {
    if(formKey.currentState.validate()){
      HelperFunctions.saveUserEmailPreferences(emailTextController.text);
      setState(() {
        _isLoading = true;
      });
      authMethods.signInWithEmail(
          emailTextController.text, passwordTextController.text)
      .then((value) {
        if(value != null){
          HelperFunctions.saveUserLoggedInPreferences(true);
          Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> DashBoard()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context,'Sign In'),
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
                    signMeIn();
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
                      "Sign In",
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
                      "Don't Have a Account? ",
                      style: kTextfieldTextStyle(),
                    ),
                    GestureDetector(
                      onTap: widget.toggle,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Register Now",
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
