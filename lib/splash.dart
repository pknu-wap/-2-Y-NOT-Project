import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'SignUpPage.dart';
import 'successPage.dart';

// 앱의 시작점인 main 함수
void main() {
  runApp(MyApp());
}

// MyApp 클래스는 StatelessWidget을 상속받아 생성
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // 앱의 제목 설정
      theme: ThemeData(
        primarySwatch: Colors.orange, // 기본 테마 색상 설정
      ),
      home: HomeScreen(), // 홈 화면으로 HomeScreen 설정
    );
  }
}

// HomeScreen 클래스는 StatelessWidget을 상속받아 생성
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFE4D02), // 화면 배경 색상 설정
      body: Center(
        child: SingleChildScrollView( // 스크롤 가능하게 설정
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
            children: [
              SizedBox(height: 140), // 140픽셀 높이의 빈 공간 추가
              Image.network(
                'https://i.ibb.co/2nqxBtx/2024-06-06-212336.png', // 이미지 URL
                width: 300,
                height: 300,
              ),
              SizedBox(height: 30), // 30픽셀 높이의 빈 공간 추가
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE8653), // 버튼 배경 색상 설정
                  minimumSize: Size(200, 50), // 버튼 최소 크기 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // 버튼 테두리 둥글게 설정
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), // 로그인 페이지로 이동
                  );
                },
                child: Text(
                  '로그인', // 버튼 텍스트 설정
                  style: TextStyle(color: Colors.white), // 텍스트 색상 설정
                ),
              ),
              SizedBox(height: 20), // 20픽셀 높이의 빈 공간 추가
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE8653), // 버튼 배경 색상 설정
                  minimumSize: Size(200, 50), // 버튼 최소 크기 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // 버튼 테두리 둥글게 설정
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpForm()), // 회원가입 페이지로 이동
                  );
                },
                child: Text(
                  '회원가입', // 버튼 텍스트 설정
                  style: TextStyle(color: Colors.white), // 텍스트 색상 설정
                ),
              ),
              SizedBox(height: 5), // 5픽셀 높이의 빈 공간 추가
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()), // 메인 페이지로 이동
                  );
                },
                child: Text(
                  '로그인 없이 구경하기', // 버튼 텍스트 설정
                  style: TextStyle(color: Colors.white), // 텍스트 색상 설정
                ),
              ),
              SizedBox(height: 30), // 30픽셀 높이의 빈 공간 추가
              Text(
                'Y-NOT', // 텍스트 설정
                style: TextStyle(
                  fontSize: 30, // 텍스트 크기 설정
                  color: Colors.white, // 텍스트 색상 설정
                  fontWeight: FontWeight.bold, // 텍스트 굵기 설정
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
