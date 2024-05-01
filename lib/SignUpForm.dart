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
  final TextEditingController _idController = TextEditingController();

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
                      borderRadius: BorderRadius.circular(16.0), // 입력 창 테두리를 더 둥글게 만듭니다.
                    ), // 입력 창 테두리 설정
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
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: '아이디',
                    hintText: 'ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // 입력 창 테두리
                    ), // 입력 창 테두리 설정
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return '아이디를 입력하세요';
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
                      borderRadius: BorderRadius.circular(16.0), // 입력 창 테두리
                    ), // 입력 창 테두리 설정
                  ),
                  validator: validateEmail, // 이메일 유효성 검사
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
                      borderRadius: BorderRadius.circular(16.0), // 입력 창 테두리
                    ), // 입력 창 테두리 설정
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
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                  },
                  child: Container(
                    height: 48.0,
                    child: Center(
                      child: Text('가입'),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFE4D02)), // FE4D02 색상
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // 버튼 글자 색상
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 24.0)), // 여백 조정
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0), // 모서리를 둥글게 만들기 위한 값 조절
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0), // 취소 버튼과의 간격
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 150.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // 이전 화면으로 돌아가는 기능
                  },
                  child: Container(
                    height: 48.0,
                    child: Center(
                      child: Text('취소'),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFE4D02)), // FE4D02 색상
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // 버튼 글자 색상
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 24.0)), // 여백 조정
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0), // 모서리를 둥글게 만들기 위한 값 조절
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

class SignUpSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('가입 완료'),
      ),
      body: Center(
        child: Text('회원 가입이 완료되었습니다!'),
      ),
    );
  }
}