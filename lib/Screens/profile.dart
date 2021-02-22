import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicare/services/database.dart';
import 'package:medicare/widgets/widgets.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  String email;
  ProfilePage({this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController name = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  DocumentSnapshot snapshotUserInfo;
  bool isLoading = false;

  @override
  void initState() {
    print(widget.email);
    // TODO: implement initState
    super.initState();
    databaseMethods.getGeneralUserData(widget.email).then((value) {
      snapshotUserInfo = value;
      name.text = snapshotUserInfo.data()['name'];
      age.text = snapshotUserInfo.data()['age'];
      gender.text = snapshotUserInfo.data()['gender'];
      phone.text = snapshotUserInfo.data()['phone'];
      address.text = snapshotUserInfo.data()['address'];
    });
  }

  profileChange() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(
      Duration(
        seconds: 3,
      ),
        (){
        setState(() {
          isLoading = false;
        });
        }
    );
    Map<String, String> userMap = {
      'name': name.text,
      'age': age.text,
      'gender': gender.text,
      'phone': phone.text,
      'address': address.text
    };
    databaseMethods.uploadUserData(userMap, widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Container(
      child: Center(child: CircularProgressIndicator()),
    ):
      Scaffold(
      appBar: appBarMain(context, 'Profile'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Personal Profile",
                    style: TextStyle(
                        fontSize: 25,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.double),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                ///FullName
                ListTile(
                  leading: Text(
                    'FullName:',
                    style: TextStyle(fontSize: 18),
                  ),
                  title: TextFormField(
                    controller: name,
                    style: kTextfieldTextStyle(),
                    decoration: kTextfieldInputDecoration(name.text),
                  ),
                ),

                ///Age
                ListTile(
                  leading: Text(
                    'Age:',
                    style: TextStyle(fontSize: 18),
                  ),
                  title: TextFormField(
                    controller: age,
                    style: kTextfieldTextStyle(),
                    decoration: kTextfieldInputDecoration(age.text),
                  ),
                ),

                ///Gender
                ListTile(
                  leading: Text(
                    'Gender:',
                    style: TextStyle(fontSize: 18),
                  ),
                  title: TextFormField(
                    controller: gender,
                    style: kTextfieldTextStyle(),
                    decoration: kTextfieldInputDecoration(gender.text),
                  ),
                ),

                ///email
                ListTile(
                  leading: Text(
                    'email:',
                    style: TextStyle(fontSize: 18),
                  ),
                  title: Text(widget.email),
                ),

                ///Phone
                ListTile(
                  leading: Text(
                    'Phone Number:',
                    style: TextStyle(fontSize: 18),
                  ),
                  title: TextFormField(
                    controller: phone,
                    style: kTextfieldTextStyle(),
                    decoration: kTextfieldInputDecoration(phone.text),
                  ),
                ),

                SizedBox(
                  height: 12,
                ),
                ///Address
                Column(
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    TextFormField(
                      controller: address,
                      style: kTextfieldTextStyle(),
                      decoration: kTextfieldInputDecoration(address.text),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    profileChange();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey,
                    ),
                    child: Text(
                      "Save",
                      style: kTextfieldTextStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
