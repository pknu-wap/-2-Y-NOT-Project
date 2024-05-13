import 'package:flutter/material.dart';
import 'package:flutter_01/LoginPage.dart';
import 'package:get/get.dart';
import 'package:flutter_01/successPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_01/Searchresult.dart';
import 'package:flutter_01/Book_SearchList.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        '/success': (context) => Main_Page(),//BookList(Searchresult: searchresult),
      },
      home: LoginPage(),
    );
  }
}
