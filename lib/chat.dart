import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
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
          
      ),
    );
  }
}