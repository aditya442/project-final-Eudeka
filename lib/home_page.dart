import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detail_page.dart';



class Home_page extends StatefulWidget{
  @override
  HomeState createState()=> HomeState();
}
class HomeState extends State<Home_page>{

  List list;
  Future<List> getData() async {
    final response = await http.get("http://adityo.xyz/final_page/get_makanan.php");
    return json.decode(response.body);

  }

  void initState() {
    super.initState();
    this.getData();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold( drawer: new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(accountName:Text(''), accountEmail:Text('',style: TextStyle(fontSize: 20),),
            currentAccountPicture: new CircleAvatar(backgroundColor: Colors.white,child: Image.asset('assets/images/person2.png',height: 50,),),
            decoration: new BoxDecoration(color: Colors.deepPurple),
            otherAccountsPictures: <Widget>[
              //  new CircleAvatar(backgroundColor: Colors.black26,child: new Text('y'),),
              //  new CircleAvatar(backgroundColor: Colors.black26,child: new Text('W'),),
            ],),

          ListTile(
            title: Text('Tentang'),
          )
        ],
      ),
    ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
            list: snapshot.data,
          )
              : new Center(
                 child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  final TextEditingController _filter = new TextEditingController();

  List nama_makanan = new List();

  List filterednama_makanan= new List();

  Future<List> getcari() async {
    final response = await http.get('http://adityo.xyz/final_page/cari_makanan.php?nama_makanan='+ _filter.text);
    return json.decode(response.body);

  }

  void initState() {
    this.getcari();
  }



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: SingleChildScrollView(
              // margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height:170,
                        width: double.infinity,
                        color: Colors.deepPurple,
                      ),
                      Column(
                        children: <Widget>[
                          AppBar(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            title: Text('Menu Makanan'),
                            actions: <Widget>[
                              IconButton(onPressed: (){
                                getcari();
                                },
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 80),
                                  child: Icon(Icons.search),
                                ),
                              ),
                              // Icon(Icons.threesixty),
                            ],


                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: Column(

                          children: <Widget>[

                            Container(
                              margin: EdgeInsets.all(15),
                              child: Card(
                                child: Container(

                                  child: TextField(
                                    controller: _filter,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                                      hintText: "Cari Makanan",
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.fastfood),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 25.0,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
          //  childAspectRatio : 5.0,
            //  childAspectRatio: (itemWidth / itemHeight),
          ),
          delegate:
          SliverChildBuilderDelegate((BuildContext context, int index){
            return new Container(

              child: new GestureDetector(
                onTap:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> Detail_page(list:list , index: index,)));
                },
                child: Container(

                  child: Card(
                    child: ListTile(
                      title: Container(

                                    child: Image.network('${list[index]['images']}',height: 130,fit: BoxFit.cover,)
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text('${list[index]['nama_makanan']}'),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }, childCount: list == null ? 0 : list.length),
        ),
      ],
    );
  }
}