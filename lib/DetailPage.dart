import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? _selectedValue; // nullable로 변경
  final List<String> _dummyImageUrls = [
    "https://via.placeholder.com/350",
    "https://via.placeholder.com/350",
    "https://via.placeholder.com/350",
    "https://via.placeholder.com/350",
    "https://via.placeholder.com/350",
  ]; // 더미 이미지 URL 목록

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x0fffffff), // 상단 바 배경색을 흰색으로 설정
        title: const Text(
          '상세 정보',
          style: TextStyle(color: Colors.black), // 텍스트를 흰색으로 설정
        ),
        centerTitle: true, // 텍스트를 중앙에 배치
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // 뒤로가기 아이콘
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로가기 버튼 클릭 시 이전 페이지로 돌아가기
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // 오른쪽 여백 추가
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // 아이콘 내부 색상을 흰색으로 설정
                  ),
                  child: const Icon(
                    Icons.notifications, // 알림 아이콘
                    color: Color(0xFFFE4D02), // 아이콘 테두리 색상 설정
                    size: 24, // 알림 아이콘 크기 설정
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const Divider(
            height: 1, // 선의 높이 설정
            color: Colors.grey, // 선의 색상 설정
          ),
          Expanded(
            child: Container(
              color: Colors.white, // 바디 배경색을 흰색으로 설정
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 250.0, // 사진 크기를 더 크게 조정
                    child: PageView.builder(
                      itemCount: _dummyImageUrls.length,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(_dummyImageUrls[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0), // 버튼 주위의 여백 설정
        color: Colors.white, // 배경 색상 설정
        child: ElevatedButton(
          onPressed: () {
            // 채팅하기 버튼을 누르면 채팅창으로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFE4D02), // 버튼의 배경 색상을 FFFE4D02로 설정
            shape: RoundedRectangleBorder( // 버튼의 모서리를 조절하는 설정
              borderRadius: BorderRadius.circular(8.0), // 모서리를 8.0으로 조절
            ),
            minimumSize: const Size(double.infinity, 50), // 버튼의 최소 크기 설정
          ),
          child: const SizedBox(
            width: double.infinity, // 버튼의 가로 크기를 화면 전체로 설정
            child: Text(
              '채팅 하기',
              textAlign: TextAlign.center, // 텍스트를 가운데로 정렬
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: DetailPage(),
  ));
}
