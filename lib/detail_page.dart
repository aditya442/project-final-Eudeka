import 'package:flutter/material.dart';

class Detail_page extends StatefulWidget{
  List list;
  int index;
  Detail_page({this.list,this.index});
  @override
  DetailState createState()=> DetailState();
}
class DetailState extends State<Detail_page>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['nama_makanan']}"),
        backgroundColor: Colors.deepPurple,
      ),
      body: new SingleChildScrollView(
        child: new Container(
          margin: EdgeInsets.all(15),
          child: new Column(
            children: <Widget>[

              new Padding(padding: const EdgeInsets.only(top: 30.0),),
              new Text("${widget.list[widget.index]['nama_makanan']}", style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.w800),),
              new Padding(padding: EdgeInsets.only(top: 5),),
              new Image.network("${widget.list[widget.index]['images']}"),
              new Padding(padding: EdgeInsets.only(top: 15),),
              new Text(" ${widget.list[widget.index]['detail']}", style: new TextStyle(fontSize: 18.0,),),

            ],
          ),
        ),
      ),

    );
  }
}