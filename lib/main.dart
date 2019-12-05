import 'dart:convert';

import 'dart:async';

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(
    title: 'Quotes App',
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
    ),
    darkTheme:
        ThemeData(brightness: Brightness.dark, primarySwatch: Colors.red),
    home: QuotesApp(),
  ));
}

class QuotesApp extends StatefulWidget {
  @override
  _QuotesAppState createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp>
    with SingleTickerProviderStateMixin {
  String author = "Fetching...."; //
  String quote = "Fetching...."; //
  String tag;
  String quoteTitle="Quote Of The Day";
  AnimationController controller;
  bool randomQuote=true;
  Future<String> fetchQuoteOfTheDay() async {
    Map quoteMap;
    Response response = await get('https://favqs.com/api/qotd');
    /* Response response = await get(
        'https://favqs.com/api/quotes/?filter=${widget.tag}&type=tag',
        headers: {
          'Authorization': 'Token token=3388d212c6f286a19932bf93aae6eb54'
        });*/
    print(response.statusCode);
    if (response.statusCode == 200) {
      quoteMap = jsonDecode(response.body);
    }
    print(quoteMap);
    quote = quoteMap['quote']['body'];
    print(quote);
    author = quoteMap['quote']['author'];
    controller.forward(from: 0.0);
    print(author);
    loading = false;
    setState(() {});
    // print(quote);
    //author=quoteMap['author'];
  }

  Future<String> fetchQuoteByTag(String tag) async {
    Random rand = Random();
    int index = rand.nextInt(25);
    print("hi");
    Map quoteMap;
    quoteTitle=tag+' Quotes';

    Response response = await get(
        'https://favqs.com/api/quotes/?filter=$tag&type=tag',
        headers: {
          'Authorization': 'Token token=3388d212c6f286a19932bf93aae6eb54'
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      quoteMap = jsonDecode(response.body);
    }
    print(quoteMap);
    quote = quoteMap['quotes'][index]['body'];

    controller.forward(from: 0.0);
    print(quote);
    author = quoteMap['quotes'][index]['author'];
    print(author);
    loading = false;
    setState(() {});
    // print(quote);
    //author=quoteMap['author'];
  }

  @override
  void initState() {
    controller = AnimationController(
        duration: Duration(milliseconds: 1200), vsync: this, value: 0);

    // TODO: implement initState
    super.initState();
    fetchQuoteOfTheDay();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(quoteTitle,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontStyle: FontStyle.italic,
                color: Colors.white)),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Beautiful Quotes',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/rose-wallpaper.jpg'),
                  fit: BoxFit.cover,
                ),
                color: Colors.red,
              ),
            ),
            Ink(
              color: Colors.pink[100],
              child: ListTile(
                title: Text('Quote Of The Day',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                        fontStyle: FontStyle.italic)),
                onTap: () {
                  randomQuote=true;
                  loading = true;
                  setState(() {});
                  fetchQuoteOfTheDay();
                  Navigator.pop(context);
                },
              ),
            ),
            Ink(
              color: Colors.transparent,
              child: ListTile(
                title: Text('Friendship Quotes',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.red,
                      fontStyle: FontStyle.italic)),
                onTap: () {
                  randomQuote=false;
                  setState(() {});
                  tag = 'Friendship';
                  fetchQuoteByTag(tag);
                  Navigator.pop(context);
                },
              ),
            ),
            Ink(
              color:Colors.pink[100] ,
              child: ListTile(
                title: Text('Happiness Quotes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                        fontStyle: FontStyle.italic)),
                onTap: () {
                  randomQuote=false;
                  setState(() {});
                  tag = 'Happiness';
                  fetchQuoteByTag(tag);
                  Navigator.pop(context);
                },
              ),
            ),
            Ink(
              color:Colors.transparent ,
              child: ListTile(
                title: Text('Life Quotes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                        fontStyle: FontStyle.italic)),
                onTap: () {
                  randomQuote=false;
                  setState(() {});
                  tag = 'Life';
                  fetchQuoteByTag(tag);
                  Navigator.pop(context);
                },
              ),
            ),
            Ink(
              color:Colors.pink[100] ,
              child: ListTile(
                title: Text('Love Quotes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                        fontStyle: FontStyle.italic)),
                onTap: () {
                  randomQuote=false;
                  setState(() {});
                  tag = 'Love';
                  fetchQuoteByTag(tag);
                  Navigator.pop(context);
                },
              ),
            ),
            Ink(
              color:Colors.transparent,
              child: ListTile(
                title: Text('Success Quotes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                        fontStyle: FontStyle.italic)),
                onTap: () {
                  randomQuote=false;
                  setState(() {});
                  tag = 'Success';
                  fetchQuoteByTag(tag);
                  Navigator.pop(context);
                },
              ),
            ),
            Ink(
              color:Colors.pink[100] ,
              child: ListTile(
                title: Text('Technology Quotes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                        fontStyle: FontStyle.italic)),
                onTap: () {
                  randomQuote=false;
                  setState(() {});
                  tag = 'Technology';
                  fetchQuoteByTag(tag);
                  Navigator.pop(context);
                },
              ),
            ),
            Ink(
              color:Colors.transparent,
              child: ListTile(
                title: Text('Wisdom Quotes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                        fontStyle: FontStyle.italic)),
                onTap: () {
                  randomQuote=false;
                  setState(() {});
                  tag = 'Wisdom';
                  fetchQuoteByTag(tag);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 5,
                  child: ScaleTransition(
                    scale: Tween(begin: 0.5, end: 1.0).animate(controller),
                    child: Text(
                      '$quote',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,

                          fontFamily: 'Quicksand'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  flex: 1,
                  child: ScaleTransition(
                    scale: Tween(begin: 1.5, end: 1.0).animate(controller),
                    child: Text('$author',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.pinkAccent[100])),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  flex: 1,
                  child: FloatingActionButton(
                    child: AnimatedOpacity(
                      child: loading ?  CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                      ) : Icon(
                        Icons.arrow_forward,
                        color: Colors.red,
                        size: 40,
                      ),
                      opacity: (loading) ? 0 : 1,
                      duration: Duration(milliseconds: 2000),
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      loading = true;
                      setState(() {});
                      randomQuote? fetchQuoteOfTheDay(): fetchQuoteByTag(tag);


                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
