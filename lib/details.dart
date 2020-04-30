import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class Description extends StatefulWidget {
  final int index;
  Description({this.index});
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  Map userData;

  Future getData() async {
    var url =  'http://192.168.1.115:8000/details_api/';
    Map data ={
      "id" : widget.index.toString()
    };
    var body = json.encode(data);
    var resp = await http.post(url, body: body);
    var res = json.decode(resp.body);
    setState(() {
      userData = res;
    });
  }
  
  Widget bookdescription(){
    return Padding(
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Material(
      elevation: 65.0,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(1, 0),
                  blurRadius: 3,
                  spreadRadius: 5),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(6, 10),
                  blurRadius: 3,
                  spreadRadius: 2)
            ]),
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
                userData == null ? "Description not provided" : userData["description"]
              ),
          ),
        ),
      ),
    ),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userData != null ? Scaffold(
      backgroundColor: Colors.orange[900],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.2,
              child: Stack(
                children: <Widget>[
                  Image.network(
                    userData["image"],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.2,
                  ),
                  Container(
                    color: Colors.black45,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.2
                  ),
                  Positioned(
                    left: 10,
                    top: 32,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ),
                  Positioned(
                    top: 32,
                    right: 10,
                    child: InkWell(
                      onTap: (){
                        var message = "Hey, check out this book of " + userData["title"] + " by " + userData["author"] + " at http://192.168.1.115:8000/details/" + widget.index.toString();
                        Share.share(message);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text("${userData["title"]}",
                style: GoogleFonts.raleway(
                    fontSize: 25, color: Colors.white, letterSpacing: 2)),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Owner: ${userData["author"]}",
                style: GoogleFonts.raleway(
                  fontSize: 15,
                  color: Colors.white,
                )
              ),
            ),
            SizedBox(
              height: 25,
            ),
            bookdescription()
          ]
        ),
      )
    ) : Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
