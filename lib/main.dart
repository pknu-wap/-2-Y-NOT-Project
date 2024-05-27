import 'package:flutter/material.dart';
import 'package:flutter_01/LoginPage.dart';
import 'package:flutter_01/Make_BookList.dart';
import 'package:flutter_01/About Chat/ChatList.dart';
import 'package:get/get.dart';
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/Searchresult.dart';
import 'package:flutter_01/Book_SearchList.dart';
import 'package:flutter_01/About Chat/ChatList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final searchresult = data;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFE4D02), // 상단바 배경 색상
        ),
      ),
      initialRoute: '/',
      routes: {
        '/success': (context) => ChatListScreen(),//BookList(Searchresult: searchresult),
      },
      home: LoginPage(),
    );
  }
}