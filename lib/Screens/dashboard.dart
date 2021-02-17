import 'package:flutter/material.dart';
import 'package:medicare/Screens/profile.dart';
import 'package:medicare/Screens/signin.dart';
import 'package:medicare/services/auth.dart';
import 'package:medicare/widgets/widgets.dart';

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
        backgroundColor: Colors.green,
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
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
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context)=> ProfilePage(),)
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.fromLTRB(40, 30, 0, 0),
                      color: Colors.green,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
