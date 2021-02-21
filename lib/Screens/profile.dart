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
  DocumentSnapshot snapshotUserInfo;


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
    });
  }

  profileChange() {
    Map<String,String> userMap = {
      'name': name.text,
      'age': age.text,
      'gender': gender.text
    };
    databaseMethods.uploadUserData(userMap,widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, 'Profile'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Text(
                    'FullName',
                    style: TextStyle(fontSize: 15),
                  ),
                  title: TextFormField(
                    controller: name,
                    style: kTextfieldTextStyle(),
                    decoration: kTextfieldInputDecoration(name.text),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Age',
                    style: TextStyle(fontSize: 15),
                  ),
                  title: TextFormField(
                    controller: age,
                    style: kTextfieldTextStyle(),
                    decoration: kTextfieldInputDecoration(age.text),
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Gender',
                    style: TextStyle(fontSize: 15),
                  ),
                  title: TextFormField(
                    controller: gender,
                    style: kTextfieldTextStyle(),
                    decoration: kTextfieldInputDecoration(gender.text),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    profileChange();
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
