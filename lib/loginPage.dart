import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat/chat.dart';
import 'package:flutter_01/SignUpPage.dart';
import 'package:flutter_01/successPage.dart';
import 'About Chat/chat.dart';

class LoginController extends GetxController {
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 로그인 시 사용하는 데이터
  RxInt isPressed = 0.obs;
  var userPassword = "".obs;
  var userEmail = "".obs;

  Future<bool> login() async {
    print(userEmail);
    print(userPassword);
    print("here");
    try {
      final credential = await _authentication.signInWithEmailAndPassword(
        email: userEmail.value,
        password: userPassword.value,
      );

      print("------");
      print(credential);

      QuerySnapshot snapshot = await _db
          .collection('users')
          .where('userId', isEqualTo: credential.user!.uid)
          .get();

      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      //honprint(e.code);
      switch (e.code) {
        case 'user-not-found':
          errorMessage = '사용자를 찾을 수 없습니다.';
          break;
        case 'wrong-password':
          errorMessage = '비밀번호가 잘못되었습니다.';
          break;
        default:
          errorMessage = '로그인에 실패했습니다.';
      }
      print("Error : ${e}");
      Get.snackbar(
        '로그인 실패', // 제목
        errorMessage, // 메시지
      );
      return false;
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 300, left: 30, right: 30),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '이메일을 입력해주세요.';
                  } else {
                    return null;
                  }
                },
                onSaved: (val) => _loginController.userEmail.value = val ?? '',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '이메일',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                obscureText: true,
                autofocus: true,
                validator: (val) {
                  if (val!.isEmpty) {
                    return '비밀번호를 입력해주세요.';
                  } else {
                    return null;
                  }
                },
                onSaved: (val) =>
                _loginController.userPassword.value = val ?? '',
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '비밀번호',
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 150),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    _key.currentState!.save();
                    bool loginSuccess = await _loginController
                        .login(); // 로그인 시도 후 결과 저장
                    if (loginSuccess) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              MainPage())); // 로그인 성공 시 페이지 이동
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    "로그인",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () =>
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpForm())),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    "회원가입",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
