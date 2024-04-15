import 'package:flutter/material.dart';
import 'package:flutter_01/user.dart';

class Main_Page extends StatefulWidget {
  const Main_Page({super.key});
  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  @override

  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(useMaterial3: true);
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top:50),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children:[
              Container(
                child:Row(
                  children:[
                    Container(
                      padding:const EdgeInsets.only(left:300),
                      child: const Icon(Icons.bookmark_outline_outlined),
                    ),
                    Container(
                      padding:const EdgeInsets.only(left:10),
                       child: const Icon(Icons.notifications_none),
                    ),
                   ],
                 )
              ),
              Container(
                padding:const EdgeInsets.only(top:20),
                child: const SearchBar(
                    trailing:[Icon(Icons.search)]
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top:30,bottom:5,right:180),
                child: const Text(
                  "User님의 활동내역",
                  style: TextStyle(
                    fontSize: 18,),),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      child: Image.asset('image/picture_1.png',height:150,width:150),
                      padding:EdgeInsets.all(10)
                    ),
                    Container(
                        child: Image.asset('image/picture_2.png',height:150,width:150),
                        padding:EdgeInsets.all(10)
                    ),
                    Container(
                        child: Image.asset('image/picture_3.png',height:150,width:150),
                        padding:EdgeInsets.all(10)
                    ),
                    Container(
                        child: Image.asset('image/picture_4.png',height:150,width:150),
                        padding:EdgeInsets.all(10)
                    ),
                    Container(
                        child: Image.asset('image/picture_5.png',height:150,width:150),
                        padding:EdgeInsets.all(10)
                    ),
                  ],
                ),
              ),

            ]
          )
        ),
      ),
    );
  }
}



