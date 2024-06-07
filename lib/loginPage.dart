import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_01/Book_SearchList.dart';
import 'package:flutter_01/successPage.dart';
import 'package:get/get.dart';
import 'SignUpPage.dart';
import 'splash.dart'; // Ensure this is the correct import

class LoginController extends GetxController { // 로그인 컨트롤러 클래스
  final FirebaseAuth _authentication = FirebaseAuth.instance; // Firebase 인증 인스턴스 생성
  final FirebaseFirestore _db = FirebaseFirestore.instance; // Firestore 인스턴스 생성

  // 로그인 시 사용하는 데이터
  RxInt isPressed = 0.obs; // 버튼이 눌렸는지 여부를 나타내는 변수
  var userPassword = "".obs; // 사용자 비밀번호를 저장하는 변수
  var userEmail = "".obs; // 사용자 이메일을 저장하는 변수

  // 로그인 함수
  Future<bool> login() async {
    print(userEmail);
    print(userPassword);
    print("here");
    try {
      final credential = await _authentication.signInWithEmailAndPassword(
        email: userEmail.value, // 입력한 이메일
        password: userPassword.value, // 입력한 비밀번호
      );

      print("------");
      print(credential);

      // Firestore에서 사용자 데이터 가져오기
      QuerySnapshot snapshot = await _db
          .collection('user')
          .where('userId', isEqualTo: credential.user!.uid)
          .get();

      return true; // 로그인 성공
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found': // 사용자를 찾을 수 없을 때
          errorMessage = '사용자를 찾을 수 없습니다.';
          break;
        case 'wrong-password': // 비밀번호가 잘못되었을 때
          errorMessage = '비밀번호가 잘못되었습니다.';
          break;
        default: // 기타 오류
          errorMessage = '로그인에 실패했습니다.';
      }
      print("Error : ${e}");
      // GetX를 사용하여 스낵바로 오류 메시지 표시
      Get.snackbar(
        '로그인 실패', // 제목
        errorMessage, // 메시지
      );
      return false; // 로그인 실패
    }
  }
}

class LoginPage extends StatefulWidget { // 로그인 페이지 위젯
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState(); // 상태 생성
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>(); // 폼 키
  final LoginController _loginController = Get.put(LoginController()); // 로그인 컨트롤러 인스턴스

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 250, left: 30, right: 30), // 패딩 설정
        child: Form(
          key: _key, // 폼 키 설정
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '이메일을 입력해주세요.'; // 이메일 유효성 검사
                  } else {
                    return null;
                  }
                },
                onSaved: (val) => _loginController.userEmail.value = val ?? '', // 이메일 저장
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // 테두리 색상 설정
                  ),
                  labelText: '이메일',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey, // 라벨 색상 설정
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                obscureText: true, // 비밀번호 가리기
                autofocus: true,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '비밀번호를 입력해주세요.'; // 비밀번호 유효성 검사
                  } else {
                    return null;
                  }
                },
                onSaved: (val) => _loginController.userPassword.value = val ?? '', // 비밀번호 저장
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // 테두리 색상 설정
                  ),
                  labelText: '비밀번호',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey, // 라벨 색상 설정
                  ),
                ),
              ),
              const SizedBox(height: 120),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) { // 폼 유효성 검사
                    _key.currentState!.save(); // 폼 저장
                    bool loginSuccess = await _loginController.login(); // 로그인 시도 후 결과 저장
                    if (loginSuccess) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage())); // 로그인 성공 시 페이지 이동
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(13),
                  child: const Text(
                    "로그인",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // 버튼 텍스트 색상 설정
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE4D02), // 버튼 배경 색상 설정
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyApp())), // 스플래시 화면으로 이동
                child: Container(
                  padding: const EdgeInsets.all(13),
                  child: const Text(
                    "취소",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // 버튼 텍스트 색상 설정
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE4D02), // 버튼 배경 색상 설정
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()), // 로그인 없이 메인 페이지로 이동
                  );
                },
                child: const Text(
                  '로그인 없이 구경하기',
                  style: TextStyle(color: Colors.grey), // 버튼 텍스트 색상 설정
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}