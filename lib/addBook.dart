import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Book extends StatefulWidget {
  final String user;
  Book({@required this.user});
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  File imageFile;
  TextEditingController nameController = TextEditingController();
	TextEditingController descriptionController = TextEditingController();
	TextEditingController conditionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Books'),
        centerTitle: true,
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
              Padding(
                padding: EdgeInsets.only(
                  top:35.0
                )
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                  height: 50.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color:Color(0xFFF9F9F9).withOpacity(0.7) ,
                  ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  textInputAction: TextInputAction.done,
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.library_books,color: Colors.grey,),
                    hintText: 'Book name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top:40.0
                )
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                  height: 120.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color:Color(0xFFF9F9F9).withOpacity(0.7) ,
                  ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  // textInputAction: TextInputAction.newline,
                  maxLines: null,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.library_books,color: Colors.grey,),
                    hintText: 'Book description',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top:40.0
                )
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                  height: 50.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color:Color(0xFFF9F9F9).withOpacity(0.7) ,
                  ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  textInputAction: TextInputAction.done,
                  controller: conditionController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.library_books,color: Colors.grey,),
                    hintText: 'Book condition',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top:20.0,
                  bottom: 20.0
                )
              ),
              RaisedButton(
                onPressed: () async {
                  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    imageFile = image;
                  });
                },
                child: Text(
                  'Add Image',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                  ),
                ),
                color: Colors.white.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)
                ),
              ),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{      
          var url = 'https://bookexchanger.herokuapp.com/book_view_api/';
          var bytes = imageFile.readAsBytesSync();
          Map data = {
            'name' : nameController.text,
            'image': base64.encode(bytes),
            'description': descriptionController.text,
            'condition': conditionController.text,
            'author' : widget.user
          };
          var resp = await http.post(
            url,
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: json.encode(data)
          );
          print(json.decode(resp.body.toString()));
          Navigator.pop(context);
        },
        child: Icon(
          Icons.chevron_right
        ),
      )
    );
  }



}
