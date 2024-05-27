import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_01/loginPage.dart';
import 'package:flutter_01/Make_BookList.dart';
import 'package:flutter_01/chat.dart';
import 'package:get/get.dart';
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/Searchresult.dart';
import 'package:flutter_01/Book_SearchList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진이 초기화될 때까지 기다림
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(MyApp()); // MyApp 위젯을 실행
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
        '/success': (context) => MakeBookList(),//BookList(Searchresult: searchresult),
      },
      home: LoginPage(),
    );
  }
}