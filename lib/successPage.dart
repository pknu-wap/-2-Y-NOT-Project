import 'package:flutter/material.dart';
import 'user.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});
  @override
  State<SuccessPage> createState() => _SuccessPageState();
}


class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    final User args = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: const Text("Test App"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("로그인 성공"),
            Text("아이디: ${args.username}"),
            Text("비밀번호: ${args.email}"),
          ],
        ),
      ),
    );
  }
}