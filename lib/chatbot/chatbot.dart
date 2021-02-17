import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:bubble/bubble.dart';
import 'package:intl/intl.dart';
import 'package:medicare/widgets/widgets.dart';

class ChatBotPage extends StatefulWidget {
  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final messageInsert = TextEditingController();
  List<Map> messages = List();

  void response(query) async {
    AuthGoogle authGoogle =await AuthGoogle(fileJson: "assets/service.json").build();
    Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle,language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });
    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, 'Chat-Bot'),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15,bottom: 10),
              child: Text("Today, ${DateFormat('Hm').format(DateTime.now())}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context,index)=>chat(
                  messages[index]["message"].toString(),
                  messages[index]["data"]
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 5.0,
              color: Colors.greenAccent,
            ),
            Container(
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.camera_alt_outlined,color: Colors.greenAccent,size: 35,),
                ),
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15),),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageInsert,
                    decoration: InputDecoration(
                      hintText: "Enter a Message...",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    onChanged: (val){

                    },
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.send,
                    size: 30.0,
                    color: Colors.greenAccent,
                  ),
                  onPressed: (){
                    if(messageInsert.text.isEmpty){
                      print("empty message");
                    }else{
                      setState(() {
                        messages.insert(0,
                            {"data":1,"message": messageInsert.text});
                      });
                      response(messageInsert.text);
                      messageInsert.clear();
                    }
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if(!currentFocus.hasPrimaryFocus){
                      currentFocus.unfocus();
                    }
                  },
                ),

              ),
            )
          ],
        ),
      ),
    );
  }

  ///creates a bubble like whatsapp for message
  Widget chat(String message,int data){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: data == 1? MainAxisAlignment.end: MainAxisAlignment.start,
        children: [
          data ==0? Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/Chatbot.png'),
            ),
          ): Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
              radius: Radius.circular(15.0),
              color: data==0? Color.fromRGBO(23, 157, 139, 1):Colors.orangeAccent,
              elevation: 0.0,
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 200),
                          child: Text(
                            message,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          data ==1?Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/Profile.png"),
            ),
          ):Container(),
        ],
      ),
    );
  }
}
