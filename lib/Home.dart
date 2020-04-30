import 'package:book/search.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'addBook.dart';
import 'search.dart';
import 'details.dart';
import 'profile.dart';
import 'package:google_fonts/google_fonts.dart';


class Home extends StatefulWidget {

  final String username;
  Home({
    @required this.username
  });

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  Map data;
  List userData;

  Future getData() async {
    var response = await http.get("https://bookexchanger.herokuapp.com/display_api/");
    data = json.decode(response.body);
    setState(() {
      userData = data["key"];
    });
  }

   @override
  void initState() {
    super.initState();
    getData();
  WidgetsBinding.instance
      .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }
  
  Future<Null> _refresh() {
  return getData().then((getData) {
    setState(() => userData = data["key"]);
  });
}

final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          'Book Exchanger',
          style: GoogleFonts.raleway(
            fontSize: 18,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange[900],
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Book Exchanger',
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.orange[900],
              ),
            ),
            ListTile(
              title: Text('Add Books'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Book(
                      user: widget.username,
                    )
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Search Books'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Search()
                  )
                );
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(
                      username: widget.username,
                    )
                  )
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Logout'
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
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
            children: <Widget>[
              Padding(padding:EdgeInsets.only(top:32.0)),
              Expanded(
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _refresh,
                    child: ListView.builder(
                    itemCount: userData == null? 0: userData.length,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Color(0xFFF9F9F9).withOpacity(0.7),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userData[index]["image"],
                                ),
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Description(index: userData[index]["id"])
                                  ),
                                );
                              },
                              title: Text(
                                "${userData[index]["name"]}",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              )
            ],
          ),
      )
    );
  }
}
