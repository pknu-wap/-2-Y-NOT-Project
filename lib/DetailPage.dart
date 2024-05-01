import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String imageUrl;

  // 생성자를 통해 데이터를 받아옵니다.
  const BookDetailPage({
    Key? key,
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상세 정보'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 책 이미지
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // 책 제목
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            // 저자
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Author: $author',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            // 설명
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '상세 정보',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BookDetailPage(
        title: '선형대수',
        author: '강점란, 서종진, 신준용, 우창화, 윤민, 이완석',
        description:
        '책소개.',
        imageUrl: 'https://via.placeholder.com/400x600',
      ),
    );
  }
}