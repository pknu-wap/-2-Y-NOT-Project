import 'package:flutter/material.dart';

class JoinWidget extends StatelessWidget {
  const JoinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '회원 가입',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFE4D02), // 상단바 배경 색
        ),
      ),
      home: const SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('회원 가입', style: TextStyle(color: Colors.white))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: '사용자 이름',
                    hintText: '닉네임',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // 입력 창 테두리
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
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    hintText: 'example@example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0), // 입력 창 테두리
                    ), // 입력 창 테두리 설정
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return '이메일을 입력하세요';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('회원 가입 완료!')),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFE4D02)), // FE4D02 색
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // 버튼 글자 색
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 24.0)), // 여백
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0), // 모서리를 둥글게
                      ),
                    ),
                  ),
                  child: const SizedBox(
                    height: 48.0,
                    child: Center(
                      child: Text('가입'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0), // 취소 버튼과 간격
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('취소 버튼이 눌렸습니다!')),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFE4D02)), // FE4D02 색
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // 버튼 글자 색
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 24.0)), // 여백
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0), // 모서리를 둥글게
                      ),
                    ),
                  ),
                  child: const SizedBox(
                    height: 48.0,
                    child: Center(
                      child: Text('취소'),
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