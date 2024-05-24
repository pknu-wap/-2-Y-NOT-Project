import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_01/loginPage.dart';


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 이메일 형식을 확인하는 정규 표현식
  RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  // 이메일 유효성 검사 함수
  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return '이메일을 입력하세요';
    } else if (!emailRegex.hasMatch(value!)) {
      return '올바른 이메일 형식이 아닙니다';
    }
    return null;
  }

  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Firebase Authentication에 사용자 등록
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Firestore에 사용자 정보 저장
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'username': _usernameController.text,
          'email': _emailController.text,
        });

        // 회원가입 성공 시 로그인 페이지로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'weak-password':
            errorMessage = '비밀번호가 너무 약합니다.';
            break;
          case 'email-already-in-use':
            errorMessage = '이미 사용 중인 이메일입니다.';
            break;
          default:
            errorMessage = '회원가입에 실패했습니다.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('회원가입에 실패했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('회원 가입', style: TextStyle(color: Colors.white))),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 24.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: '사용자 이름',
                    hintText: '닉네임',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return '사용자 이름을 입력하세요';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    hintText: 'example@example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  validator: validateEmail,
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    hintText: '비밀번호',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return '비밀번호를 입력하세요';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 150.0),
                child: ElevatedButton(
                  onPressed: (){
                    _signUp();
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ));
                  },
                  child: Container(
                    height: 48.0,
                    child: Center(
                      child: Text('가입'),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFE4D02)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 24.0)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 150.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.0,
                    child: Center(
                      child: Text('취소'),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFE4D02)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 24.0)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
