import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_01/SignUpPage.dart';
import 'package:flutter_01/About Chat/ChatList.dart';
import 'package:get/get.dart';
import 'loginPage.dart';
import 'Book_db.dart';
import 'Book_SearchList.dart' ;
import 'splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진이 초기화될 때까지 기다림
  await Firebase.initializeApp(); // Firebase 초기화
  Get.testMode = true;
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
      home: HomeScreen(),
    );
  }
}
