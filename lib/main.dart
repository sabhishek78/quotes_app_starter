import 'dart:convert';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(
    home: QuotesApp(),
  ));
}


class QuotesApp extends StatefulWidget {
  @override
  _QuotesAppState createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  String author;
  String quote;

  Future<String> fetchQuote() async {
    Map quoteMap;

    Response response = await get('https://favqs.com/api/qotd');
    print(response.statusCode);
    if (response.statusCode == 200) {
      quoteMap = jsonDecode(response.body);
    }
    quote = quoteMap['quote']['body'];
    print(quote);
    author = quoteMap['quote']['author'];
    print(author);
    loading=false;
    setState(() {

    });
    // print(quote);
    //author=quoteMap['author'];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchQuote();

  }
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'Quote of the Day',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,fontStyle: FontStyle.italic ,
                color: Colors.white)
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Flexible(
                flex: 5,
                child: Container(
                  child: Text('$quote',
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,fontStyle: FontStyle.italic ,
                  color: Colors.black)),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text('$author',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,fontStyle: FontStyle.italic ,
                        color: Colors.red)),
              ),

              Flexible(
                flex: 1,
                child: FloatingActionButton(
                  child: AnimatedOpacity(child: Icon(Icons.arrow_forward,color: Colors.red,size: 40,),opacity: (loading)?0:1,duration: Duration(milliseconds: 2000) ,),
                  backgroundColor: Colors.white,
                  onPressed: () {
                     loading=true;
                    setState(() {

                    });
                   fetchQuote();
                  },

                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}



