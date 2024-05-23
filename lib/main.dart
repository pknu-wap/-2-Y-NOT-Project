// main.dart

import 'package:flutter/material.dart';
import 'MyPage.dart'; // MyPage.dart 파일을 임포트합니다

void main() {
  runApp(const MyApp());
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
      home: const MyPage(inputText: 'your_input_text_here'),      // MyHomePage 위젯을 초기 화면으로 사용합니다
    );
  }
}
