import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetBookDataTest extends StatefulWidget {
  const GetBookDataTest({Key? key}) : super(key: key);

  @override
  State<GetBookDataTest> createState() => _GetBookDataTestState();
}

class _GetBookDataTestState extends State<GetBookDataTest> {
  // 특정 책의 정보를 비동기적으로 가져오는 함수입니다.
  // Firestore에서 데이터를 가져오는 동안 발생할 수 있는 예외를 처리합니다.
  Future<Map<String, dynamic>?> getBookInfo() async {
    try {
      var result = await FirebaseFirestore.instance.collection('book').doc('OF8n7W20F50k7SrdvQK0').get();
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
            future: getBookInfo(),
            builder: (context, snapshot) {
              // 데이터가 성공적으로 로드되었는지 확인합니다.
              if (snapshot.connectionState == ConnectionState.done) {
                // 데이터가 있는지 확인합니다.
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  var bookTitle = data['BookTitle'] ?? 'No title';
                  var complete = data['Complete'] ?? 'No status';
                  // 데이터를 화면에 표시합니다.
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(bookTitle),
                        Text(complete.toString()), // Boolean 값인 경우 문자열로 변환해 표시합니다.
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
