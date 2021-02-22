import 'package:flutter/material.dart';
import 'package:medicare/Screens/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medicare/helper/authenticate.dart';
import 'package:medicare/helper/sharedpreference.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInState();
  }

  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInPreferences().then((value) {
      //setState(() {
        isLoggedIn = value;
      //});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MediBot",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0XFF3F51B5),
        primaryColorLight: Color(0xFFC5CAE9),
        primaryColorDark: Color(0XFF303F9F),
        accentColor: Color(0xFF607D8B),
        dividerColor: Color(0xffBDBDBD)
      ),
      home: isLoggedIn != null
          ? isLoggedIn
              ? DashBoard()
                :Authenticate()
        :Container(),
    );
  }
}
