import 'package:flutter/material.dart';
import 'user.dart';
import 'main.dart';

void main() {
  runApp(MyApp());
}

class join_submit extends StatefulWidget {
  const join_submit({super.key});
  @override
  State<join_submit> createState() => _join_submit();
}

class _join_submit extends State<join_submit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("회원가입")
          ],
        ),
      ),
    );
  }
}

