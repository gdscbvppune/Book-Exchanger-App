import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile extends StatefulWidget {

  final String username;
  Profile({
    @required this.username
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = "";
  String name = "";
  String email = "";

  bool fetched = false;

  Widget displayImage() {
    return Positioned(
      left: 100,
      top: MediaQuery.of(context).size.height / 5,
      child: Material(
        elevation: 13,
        shadowColor: Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(70.0)),
        color: Colors.orange[100],
        child: CircleAvatar(
          child: Text(
            username[0].toUpperCase(),
            style: TextStyle(color: Colors.grey[800], fontSize: 60),
          ),
          radius: 70.0,
          backgroundColor: Colors.orangeAccent,
        ),
      ),
    );
  }

  Widget backButton() {
    return Positioned(
      top: 32,
      left: 8,
      child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            size: 32,
          )),
    );
  }

  Widget displayFields() {
    return Positioned(
      top: 410,
      left: 20,
      child: Column(
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(70.0),
            elevation: 7.0,
            child: Container(
              width: 320,
              height: 55,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3, 5),
                      blurRadius: 8,
                      color: Colors.orange[800],
                    )
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                      colors: [Colors.orange[300], Colors.orange[900]])),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 18, 10, 10),
                child: Text(username,
                    style:
                        TextStyle(color: Colors.grey[200], fontSize: 22)),
              ),
            ),
          ),
          SizedBox(height: 20,),


          Material(
            borderRadius: BorderRadius.circular(70.0),
            elevation: 7.0,
            child: Container(
              width: 320,
              height: 55,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3, 5),
                      blurRadius: 8,
                      color: Colors.orange[800],
                    )
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                      colors: [Colors.orange[300], Colors.orange[900]])),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 18, 10, 10),
                child: Text(name,
                    style:
                        TextStyle(color: Colors.grey[200], fontSize: 22)),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Material(
            borderRadius: BorderRadius.circular(70.0),
            elevation: 7.0,
            child: Container(
              width: 320,
              height: 55,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(3, 5),
                      blurRadius: 8,
                      color: Colors.orange[800],
                    )
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                      colors: [Colors.orange[300], Colors.orange[900]])),
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 18, 10, 10),
                child: Text(email,
                    style:
                        TextStyle(color: Colors.grey[200], fontSize: 22)),
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  getDetails() async{
    var url = 'https://bookexchanger.herokuapp.com/profile_api/';
    Map<String, dynamic> usernameMap = {
      "username": widget.username
    };
    var details = json.encode(usernameMap);
    var resp = await http.post(url, body: details);
    var result = json.decode(resp.body.toString());
    setState(() {
      fetched = true;
      username = widget.username;
      email = result["email"];
      name = result["name"];
    });
  }

  @override
  void initState(){
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: fetched ? Stack(
      children: <Widget>[
        ClipPath(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Colors.orange[100], Colors.orange[900]])),
          ),
          clipper:GetClipper(),
        ),
        displayImage(),
        displayFields(),
        backButton(),
      ],
    ) : Center(
      child: CircularProgressIndicator(),
    )
  );
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height / 2.3);
    path.lineTo(size.width + 370, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClippper) {
    return true;
  }
}