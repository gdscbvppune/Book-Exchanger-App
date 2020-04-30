import 'package:book/Home.dart';
import 'package:flutter/material.dart';
import 'package:book/Animation/FadeAnimation.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'Home.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = new TextEditingController();

  TextEditingController passwordController = new TextEditingController();

   FocusNode passwordFocusNode = new FocusNode();

  FocusNode usernameFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange[900],
              Colors.orange[800],
              Colors.orange[400]
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Image(image: AssetImage('assets/logo1.png',)),
            ),
            // SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1, Text("Book Exchanger", style: TextStyle(color: Colors.white, fontSize: 30),)),
                  SizedBox(height: 10,),
                  // FadeAnimation(1.3, Text("Login", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        FadeAnimation(1.4, Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                            )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.none,
                                  autocorrect: false,
                                  autofocus: true,
                                  focusNode: usernameFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: (){
                                    if(usernameController.text.isNotEmpty){
                                      usernameFocusNode.unfocus();
                                      FocusScope.of(context).requestFocus(passwordFocusNode);
                                    }
                                  },
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  autocorrect: false,
                                  focusNode: passwordFocusNode,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.none,
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  onEditingComplete: (){
                                    if(passwordController.text.isNotEmpty){
                                      passwordFocusNode.unfocus();
                                    }
                                  },
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        new Padding(padding: EdgeInsets.only(bottom: 25.0)),

                        SizedBox(
                          width: 150.0,
                          height: 50.0,
                          child: new RaisedButton(onPressed: () async{
                           var url = 'https://bookexchanger.herokuapp.com/login_api/';
                           var username = usernameController.text;
                           Map data = {
                             'username' : username,
                             'password' : passwordController.text
                           };
                           var body = json.encode(data);
                            var resp = await http.post(url, body: body);
                            var res = json.decode(resp.body.toString());
                            var message = res["message"];
                            if(message == "successful"){
                              usernameController.clear();
                              passwordController.clear();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Home(
                                    username: username,
                                  )
                                )
                              );
                            }
                          },
                            child: new Text('Login',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            color: Colors.orange[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(22.0)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}