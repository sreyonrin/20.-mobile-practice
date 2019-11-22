
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main () => runApp(DemoAPI());

class DemoAPI extends StatefulWidget {
  @override
  _DemoAPIState createState() => _DemoAPIState();
}

class _DemoAPIState extends State<DemoAPI> {
  Map img;
  List imgList;
  Future getImage() async{
    http.Response response = await http.get("https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=yellow+flowers&image_type=photo&pretty=true");

    img = json.decode(response.body);
    setState(() {
      imgList = img['hits'];
    });
  }
  @override
  void initState(){
    super.initState();
    getImage();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pixaby 2020"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: imgList == null ? 0 : imgList.length,
          itemBuilder: (BuildContext context, int index){
            final imgs = imgList[index];
            return Card(
              child: Column(
              children: <Widget> [
             
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(img['largeImageURL']),
              ),  
                
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(imgs['userImageURL']),
                      radius: 25.0,
                    ),
                      Text("${imgs['tags']}"),
                  ],
                ),
               
              ),
              
              ], 
              ),
            );
          }
        ),
      ),
    );
  }
}