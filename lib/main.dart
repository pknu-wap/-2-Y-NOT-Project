import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_01/WishList.dart';
import 'MyPage.dart'; // MyPage.dart 파일을 임포트합니다
import 'package:flutter_01/loginPage.dart';
import 'package:flutter_01/Make_BookList.dart';
import 'package:flutter_01/About Chat/ChatList.dart';
import 'package:get/get.dart';
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/Book_SearchList.dart';
import 'package:flutter_01/About Chat/ChatList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진이 초기화될 때까지 기다림
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(MyApp()); // MyApp 위젯을 실행
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter My Page',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/success': (context) => ChatListScreen(),//BookList(Searchresult: searchresult),
      },
      home: LoginPage(),
    );
  }
}
