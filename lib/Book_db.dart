import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetDataTest extends StatefulWidget {
  const GetDataTest({Key? key}) : super(key: key);

  @override
  State<GetDataTest> createState() => GetDataTestState();
}

class GetDataTestState extends State<GetDataTest> {
  // 현재 로그인된 사용자의 uid를 가져옵니다.
  String uid = FirebaseAuth.instance.currentUser!.uid;

  // 사용자 정보를 비동기적으로 가져오는 함수입니다.
  // Firestore에서 데이터를 가져오는 동안 발생할 수 있는 예외를 처리합니다.
  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      var result = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return result.data() as Map<String, dynamic>?;
    } catch (e) {
      print(e); // 콘솔에 에러를 출력합니다.
      return null; // 예외 발생 시 null을 반환합니다.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>?>(
            future: getUserInfo(),
            builder: (context, snapshot) {
              // 데이터가 성공적으로 로드되었는지 확인합니다.
              if (snapshot.connectionState == ConnectionState.done) {
                // 데이터가 있는지 확인합니다.
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  var username = data['username'] ?? 'No name';
                  var email = data['email'] ?? 'No email';
                  // 데이터를 화면에 표시합니다.
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(username),
                        Text(email),
                      ],
                    ),
                  );
                } else {
                  // 데이터가 없는 경우 메시지를 표시합니다.
                  return Center(child: Text('No data available.'));
                }
              } else {
                // 데이터가 로드 중인 경우 로딩 인디케이터를 표시합니다.
                return Center(child: CircularProgressIndicator());
              }
            }
        )
    );
  }
}
