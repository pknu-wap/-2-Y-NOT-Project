import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅창'),
      ),
      body: const Center(
        child: Text('채팅창'),
      ),
    );
  }
}

class AlarmPage extends StatelessWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알람'),
      ),
      body: const Center(
        child: Text('알람 페이지'),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<String> _dummyText = [
    '첫 번째',
    '두 번째',
    '세 번째',
  ];

  int _currentPage = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF), // 상단 바 배경색을 흰색으로 설정
        title: const Text(
          '상세 정보',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // 오른쪽 여백 추가
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlarmPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Color(0xFFFE4D02),
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 250.0,
              child: PageView.builder(
                itemCount: _dummyText.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      'https://picsum.photos/250?image=9',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildPageIndicator(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _dummyText[_currentPage],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '닉네임',
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    '2024.03.03',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '선형대수',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 2,
                    color: const Color(0xFFFE4D02),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '공학이론',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '저자',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '청람',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildTag('#쑤박'),
                      const SizedBox(width: 4),
                      _buildTag('#에누리 가능'),
                      const SizedBox(width: 4),
                      _buildTag('#부경대 후문'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const Text(
                    '책 상태',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 2,
                    ),
                  ),
                  const Text(
                    '필기 여부',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 2,
                    ),
                  ),
                  const Text(
                    '구판/신판',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Container(
                    color: Colors.white, // 배경색 설정
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 내부 패딩 설정
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '판매자의 말',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                            '부경대 후문에서 거래 가능합니다.',
                            style: TextStyle(
                              fontSize: 16,
                            )
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16), // 페이지 인디케이터와 사진 사이에 간격 추가
          _buildPageIndicator(), // 페이지 인디케이터 추가
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _dummyText[_currentPage],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '닉네임',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  '2024.03.03',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 24), // 닉네임과 텍스트 사이에 여백 추가
                const Text(
                  '선형대수',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8), // 텍스트와 선 사이에 여백 추가
                Container(
                  height: 2,
                  color: const Color(0xFFFE4D02), // 선 색상 설정
                ),
                const SizedBox(height: 10), // 선과 텍스트 사이에 여백 추가
                const Text(
                  '공학이론',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 8), // 텍스트와 텍스트 사이에 여백 추가
                const Text(
                  '저자',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4), // 텍스트와 텍스트 사이에 여백 추가
                const Text(
                  '청람',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFE4D02),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const SizedBox(
            width: double.infinity,
            child: Text(
              '채팅 하기',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() { // 사진 순서에 따른 점 채우기 인디케이터
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_dummyText.length, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? const Color(0xFFFE4D02) // 선택된 페이지는 주황색으로 설정
                : Colors.grey, // 선택되지 않은 페이지는 회색으로 설정
          ),
        );
      }),
    );
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진이 초기화될 때까지 기다림
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: DetailPage(),
  ));
}