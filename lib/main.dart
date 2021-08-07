import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  _MyAppState createState() => _MyAppState();
} 

class _MyAppState extends State<MyApp> {
  Future<List> getData()async {
    final response = await http.get(Uri.parse("https://foryuapp.000webhostapp.com/user.php"));
    return json.decode(response.body);
  }

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
    appBar : AppBar(title: Text("FORYU"),),  
    body : FutureBuilder<List>(
      future:getData(),
      builder: (context, snapshot){
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
        ?new ItemList(
          list:snapshot.data.length
        )
        : new Center(child: CircularProgressIndicator(),);
      }),),);
  }
}
    
class ItemList extends StatefulWidget {
final List list;
ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context,1){
return new Container(
  padding: const EdgeInsets.all(1),
  child: new GestureDetector(
    child: new Card(
      child: new ListTile(
        title : new Text(list[i]["nama_user"]),
        leading: new Icon(Icons.widgets),
      )
    ),
  ),
);
      });
  }
}

