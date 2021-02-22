import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicare/services/database.dart';
import 'package:medicare/widgets/widgets.dart';

class ProfilePageOfAnother extends StatefulWidget {
  final String email;
  ProfilePageOfAnother({this.email});
  @override
  _ProfilePageOfAnotherState createState() => _ProfilePageOfAnotherState();
}

class _ProfilePageOfAnotherState extends State<ProfilePageOfAnother> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  ///General Info Editor
  TextEditingController name = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController address = new TextEditingController();
  ///Medical Info Editor
  TextEditingController height = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController blood = new TextEditingController();
  TextEditingController preexist = new TextEditingController();
  DocumentSnapshot snapshotUserDataInfo;
  DocumentSnapshot snapshotMedicalDataInfo;
  bool isLoading = false;

  @override
  void initState() {
    print(widget.email);
    // TODO: implement initState
    super.initState();
    databaseMethods.getGeneralUserData(widget.email).then((value) {
      setState(() {
        snapshotUserDataInfo = value;
        name.text = snapshotUserDataInfo.data()['name'];
        age.text = snapshotUserDataInfo.data()['age'];
        gender.text = snapshotUserDataInfo.data()['gender'];
        phone.text = snapshotUserDataInfo.data()['phone'];
        address.text = snapshotUserDataInfo.data()['address'];
      });
    });
    databaseMethods.getMedicalUserData(widget.email).then((value){
      setState(() {
        snapshotMedicalDataInfo = value;
        height.text = snapshotMedicalDataInfo.data()['height'];
        weight.text = snapshotMedicalDataInfo.data()['weight'];
        blood.text = snapshotMedicalDataInfo.data()['blood'];
        preexist.text = snapshotMedicalDataInfo.data()['preexist'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, 'Profile'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
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
                title: Text(
                  name.text,
                  style: kTextfieldTextStyle(),
                ),
              ),
              ///Age
              ListTile(
                leading: Text(
                  'Age:',
                  style: TextStyle(fontSize: 18),
                ),
                title: Text(
                  age.text,
                  style: kTextfieldTextStyle(),
                ),
              ),
              ///Gender
              ListTile(
                leading: Text(
                  'Gender:',
                  style: TextStyle(fontSize: 18),
                ),
                title: Text(
                  gender.text,
                  style: kTextfieldTextStyle(),
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
                title: Text(
                  phone.text,
                  style: kTextfieldTextStyle(),
                ),
              ),

              SizedBox(
                height: 12,
              ),
              ///Address
              ListTile(
                leading: Text(
                  'Address',
                  style: TextStyle(fontSize: 18),
                ),
                title: Text(
                  address.text,
                  style: kTextfieldTextStyle(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  "Medical Profile",
                  style: TextStyle(
                      fontSize: 25,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.double),
                ),
              ),
              ListTile(
                leading: Text(
                  'height',
                  style: TextStyle(fontSize: 18),
                ),
                title: Text(
                  height.text,
                  style: kTextfieldTextStyle(),
                ),
              ),
              ListTile(
                leading: Text(
                  'weight',
                  style: TextStyle(fontSize: 18),
                ),
                title: Text(
                  weight.text,
                  style: kTextfieldTextStyle(),
                ),
              ),
              ListTile(
                leading: Text(
                  'blood',
                  style: TextStyle(fontSize: 18),
                ),
                title: Text(
                  blood.text,
                  style: kTextfieldTextStyle(),
                ),
              ),
              ListTile(
                leading: Text(
                  'Pre-Existing Conditions',
                  style: TextStyle(fontSize: 18),
                ),
                title: Text(
                  preexist.text,
                  style: kTextfieldTextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
