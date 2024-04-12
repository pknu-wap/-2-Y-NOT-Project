import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'successPage.dart';
import 'user.dart';
import 'join_submit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/success': (context) => const Main_Page()
        });
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  late String _username, _pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 300, left: 30, right: 30),
        child: Form(
          key: _key,
          child: Column(
            children: [
              usernameInput(),
              const SizedBox(height: 15),
              pwdInput(),
              const SizedBox(height: 150),
              loginButton(),
              const SizedBox(height: 10),
              submitButton(),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

  Widget usernameInput() {
    return TextFormField(
      autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return '이메일을 입력해주세요.';
        } else {
          return null;
        }
      },
      onSaved: (username) => _username = username as String,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '이메일',
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget pwdInput() {
    return TextFormField(
      autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return '비밀번호를 입력해주세요.';
        } else {
          return null;
        }
      },
      onSaved: (email) => _pwd = email as String,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: '비밀번호',
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_key.currentState!.validate()) {
          _key.currentState!.save();
          Navigator.pushNamed(context, '/success',
              arguments: User(_username, _pwd));
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
    );
  }
  Widget submitButton() {
    return ElevatedButton(
      onPressed: () => Navigator.push(context,MaterialPageRoute(builder:(context) => join_submit())),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "회원가입",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
