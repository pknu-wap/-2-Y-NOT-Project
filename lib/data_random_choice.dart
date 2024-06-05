import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Firestore Document',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomDocumentScreen(),
    );
  }
}

class RandomDocumentScreen extends StatefulWidget {
  @override
  _RandomDocumentScreenState createState() => _RandomDocumentScreenState();
}

class _RandomDocumentScreenState extends State<RandomDocumentScreen> {
  String documentBokTitle = 'Loading...';
  String documentImageUrl = '';

  @override
  void initState() {
    super.initState();
    getRandomDocument();
  }

  Future<void> getRandomDocument() async {
    try {
      // Firestore 컬렉션에서 모든 문서 ID를 가져옴
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('book').get();

      // 문서 ID를 리스트에 저장
      List<String> documentIds = snapshot.docs.map((doc) => doc.id).toList();

      // 랜덤 인덱스를 생성
      Random random = Random();
      int randomIndex = random.nextInt(documentIds.length);

      // 랜덤으로 선택된 문서 ID
      String selectedDocumentId = documentIds[randomIndex];

      // 선택된 문서의 데이터를 가져옴
      DocumentSnapshot selectedDocument = await FirebaseFirestore.instance.collection('book').doc(selectedDocumentId).get();

      // 'username' 필드의 값을 가져옴
      String BookTitle = selectedDocument.get('BookTitle');
      // 'Image' 필드의 값을 가져옴 (이미지 URL)
      String imageUrl = selectedDocument.get('Image');

      // 상태 업데이트
      setState(() {
        documentBokTitle = BookTitle;
        documentImageUrl = imageUrl;
      });
    } catch (e) {
      setState(() {
        documentBokTitle = 'Error: $e';
        documentImageUrl = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Firestore Document'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                documentBokTitle,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              documentImageUrl.isNotEmpty
                  ? Image.network(documentImageUrl)
                  : SizedBox(), // 이미지 URL이 있을 경우 이미지를 표시하고, 그렇지 않으면 SizedBox를 표시하여 공간을 차지하지 않음
            ],
          ),
        ),
      ),
    );
  }
}
