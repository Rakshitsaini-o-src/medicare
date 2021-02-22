import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicare/Screens/dashboard.dart';
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
      snapshotUserDataInfo = value;
      name.text = snapshotUserDataInfo.data()['name'];
      age.text = snapshotUserDataInfo.data()['age'];
      gender.text = snapshotUserDataInfo.data()['gender'];
      phone.text = snapshotUserDataInfo.data()['phone'];
      address.text = snapshotUserDataInfo.data()['address'];
    });
    databaseMethods.getMedicalUserData(widget.email).then((value){
      snapshotMedicalDataInfo = value;
      height.text = snapshotMedicalDataInfo.data()['height'];
      weight.text = snapshotMedicalDataInfo.data()['weight'];
      blood.text = snapshotMedicalDataInfo.data()['blood'];
      preexist.text = snapshotMedicalDataInfo.data()['preexist'];
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard(email: widget.email)));
        }
    );
    Map<String, String> generalUserMap = {
      'name': name.text,
      'age': age.text,
      'gender': gender.text,
      'phone': phone.text,
      'address': address.text
    };
    Map<String,String> medicalUserMap = {
      'height': height.text,
      'weight': weight.text,
      'blood': blood.text,
      'preexist': preexist.text
    };
    databaseMethods.uploadUserData(generalUserMap, widget.email);
    databaseMethods.uploadMedicalData(medicalUserMap, widget.email);
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
                  title: TextFormField(
                    controller: height,
                    style: kTextfieldTextStyle(),
                    decoration: kTextfieldInputDecoration(height.text),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'weight',
                    style: TextStyle(fontSize: 18),
                  ),
                  title: TextFormField(
                    controller: weight,
                    style: kTextfieldTextStyle(),
                    decoration: kTextfieldInputDecoration(weight.text),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'blood',
                    style: TextStyle(fontSize: 18),
                  ),
                  title: TextFormField(
                    controller: blood,
                    style: kTextfieldTextStyle(),
                    decoration: kTextfieldInputDecoration(blood.text),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Pre-Existing Conditions',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    TextFormField(
                      controller: preexist,
                      style: kTextfieldTextStyle(),
                      decoration: kTextfieldInputDecoration(preexist.text),
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
