import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List queryData;
  Map res;

  TextEditingController _srchQueryController = new TextEditingController();

    Future searchData()async{
    var url = 'https://bookexchanger.herokuapp.com/search_api/';
    Map data = {
      "query" : _srchQueryController.text
    };
    var body = json.encode(data);
    var resp = await http.post(url, body: body);
    res = json.decode(resp.body);
    setState(() {
      queryData = res["key"];
    });
      
  }
   @override
  void initState() {
    super.initState();
    searchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BookEx'),
        backgroundColor: Colors.orange[900],
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
              new Padding(padding:EdgeInsets.only(top:50.0)),
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 20.0),
                  height: 50.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color:Color(0xFFF9F9F9).withOpacity(0.7) ,
                  ),
                  child: Center(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      textInputAction: TextInputAction.search,
                      controller: _srchQueryController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,color: Colors.grey,),
                        hintText: "What book you would like to search",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none
                      ),
                      onSubmitted: (val){
                        searchData();
                      },
                    ),
                  ),
                ),
              ),
              new FloatingActionButton(
                onPressed: (){searchData();},
              child: Icon(Icons.search),
              backgroundColor: Colors.white.withOpacity(0.7),
              ),
              Expanded(
                  child: new ListView.builder(
                    itemCount: queryData == null? 0: queryData.length,
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
                                  queryData[index]["image"],
                                ),
                              ),
                              onTap: (){
                              },
                              title: Text(
                                "${queryData[index]["name"]}",
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
              )
            ],
          ),
      )
      
    );
  }}


