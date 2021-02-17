import 'package:flutter/material.dart';
import 'package:medicare/Screens/profile.dart';
import 'package:medicare/chatbot/chatbot.dart';
import 'package:medicare/helper/authenticate.dart';
import 'package:medicare/helper/sharedpreference.dart';
import 'package:medicare/services/auth.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  AuthMethods _auth =  new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home Page'),
        centerTitle: true,
        backgroundColor: Color(0xff5077be),
        elevation: 0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(
              'LogOut',
              style: TextStyle(color:Colors.black),
            ),
            onPressed: () async{
              await _auth.signOut();
              HelperFunctions.saveUserLoggedInPreferences(false);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Authenticate()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            FittedBox(
              child: Row(
                children: <Widget>[
                  ///Profile Card
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context)=> ProfilePage(),)
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.fromLTRB(40, 30, 0, 0),
                      color: Color(0xff5077be),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                                'assets/images/Profile.png',
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ///ChatBot
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> ChatBotPage(),)
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.fromLTRB(40, 30, 0, 0),
                      color: Color(0xff5077be),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/Chatbot.png',
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: Text(
                                'ChatBot',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
