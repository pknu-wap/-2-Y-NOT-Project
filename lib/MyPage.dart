import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart'; // GetX 패키지를 사용하는 경우 추가
import 'package:flutter_01/Book_SearchList.dart' as BookSearch;
// 다른 곳에서 사용할 때는 BookSearch.BookInfo, BookSearch.BookList로 접근import 'package:flutter_01/WishList.dart';
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/WishList.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Center(
        child: Text('This is the chat screen'),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  final String inputText;

  const MyPage({Key? key, this.inputText = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '마이페이지',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 이전 페이지로 이동
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // 오른쪽에 약간의 패딩 추가
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Color(0xFFFE4D02)),
              // 아이콘 색상 변경
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsPage()), // 알림 페이지로 이동
                );
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey, // 경계선 색상 설정
            height: 2.0, // 경계선 두께 설정
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildProfileSection(context), // 프로필 섹션 추가
          _buildCategorySection(context), // 카테고리 섹션 추가
          _buildPurchaseAndRentalSection(context), // 나의 구매 및 대여 섹션 추가
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookSearch.BookList(
                    Searchresult: BookSearch.BookInfo(
                      subject: '', // 검색어를 빈 문자열로 설정 (필요에 따라 수정)
                      author: '',
                      publishing: '',
                    ),
                  ),
                ),
              );
              break;
            case 2:
              Get.to(ChatScreen());
              break;
            case 3:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyPage()));
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_outlined,
              ),
              label: '판매'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: '채팅'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: '정보'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage('https://example.com/profile.jpg'), // 프로필 이미지를 여기에 대체하세요
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFE4D02),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: const Text(
                      '초보판매자',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    '닉네임',
                    style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 1.0),
          GestureDetector(
            onTap: () {
              _showImagePicker(context); // 프로필 수정 텍스트를 눌렀을 때 모달창을 열어줍니다.
            },
            child: Container(
              padding: const EdgeInsets.only(left: 4.0), // 왼쪽 여백 추가
              child: const Text(
                '프로필 수정',
                style: TextStyle(color: Color(0xFFFE4D02), fontSize: 8), // 작게 FE402 색으로 설정
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('카메라로 찍기'),
                onTap: () {
                  _getImage(context, ImageSource.camera); // 카메라로 이미지 가져오기
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 가져오기'),
                onTap: () {
                  _getImage(context, ImageSource.gallery); // 갤러리에서 이미지 가져오기
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _getImage(BuildContext context, ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source); // 이미지 가져오기

    // 이미지가 선택되었는지 확인
    if (pickedFile != null) {
      // 선택된 이미지를 보여주는 다이얼로그 또는 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('선택된 이미지'),
            ),
            body: Center(
              child: Image.file(
                File(pickedFile.path), // 선택된 이미지 파일의 경로를 사용하여 이미지를 보여줍니다.
              ),
            ),
          ),
        ),
      );
    } else {
      // 이미지가 선택되지 않았을 때의 처리
      // (예를 들어, 사용자가 갤러리나 카메라를 취소한 경우)
      print('이미지 선택이 취소되었습니다.');
    }
  }

  Widget _buildCategorySection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '나의 판매 및 대여',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildMenuItem(
            text: '판매 내역',
            onTap: () {
              // 판매내역 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SalesHistoryPage()),
              );
            },
          ),
          _buildMenuItem(
            text: '대여 내역',
            onTap: () {
              // 대여내역 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RentalHistoryPage()),
              );
            },
          ),
          _buildMenuItem(
            text: '후기',
            onTap: () {
              // 후기 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReviewsPage()),
              );
            },
          ),
          _buildMenuItem(
            text: '내 상품 관리',
            onTap: () {
              // 내 상품 관리 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyItemsManagementPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseAndRentalSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '나의 구매 및 대여',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          _buildMenuItem(
            text: '찜목록',
            onTap: () {
              // 찜목록 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishListForm()
                ),
              );
            },
          ),
          _buildMenuItem(
            text: '구매 내역',
            onTap: () {
              // 구매 내역 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PurchaseHistoryPage()),
              );
            },
          ),
          _buildMenuItem(
            text: '최근 본 상품',
            onTap: () {
              // 최근 본 상품 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecentlyViewedItemsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({required String text, required VoidCallback onTap}) {
    return ListTile(
      title: Text(text),
      onTap: onTap,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
      ),
      body: const Center(
        child: Text('홈 페이지'),
      ),
    );
  }
}

class SalesPage extends StatelessWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('판매'),
      ),
      body: const Center(
        child: Text('판매 페이지'),
      ),
    );
  }
}

class RentalPage extends StatelessWidget {
  const RentalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('대여'),
      ),
      body: const Center(
        child: Text('대여 페이지'),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅'),
      ),
      body: const Center(
        child: Text('채팅 페이지'),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림페이지'),
      ),
      body: const Center(
        child: Text(' '),
      ),
    );
  }
}

class SalesHistoryPage extends StatelessWidget {
  const SalesHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('판매 내역'),
      ),
      body: const Center(
        child: Text(' '),
      ),
    );
  }
}

class RentalHistoryPage extends StatelessWidget {
  const RentalHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('대여 내역'),
      ),
      body: const Center(
        child: Text(' '),
      ),
    );
  }
}

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('후기'),
      ),
      body: const Center(
        child: Text(' '),
      ),
    );
  }
}

class MyItemsManagementPage extends StatelessWidget {
  const MyItemsManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 상품 관리'),
      ),
      body: const Center(
        child: Text(' '),
      ),
    );
  }
}

class WishListPage extends StatelessWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('찜 목록'),
      ),
      body: const Center(
        child: Text(' '),
      ),
    );
  }
}

class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('구매 내역'),
      ),
      body: const Center(
        child: Text(' '),
      ),
    );
  }
}

class RecentlyViewedItemsPage extends StatelessWidget {
  const RecentlyViewedItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('최근 본 상품'),
      ),
      body: const Center(
        child: Text(' '),
      ),
    );
  }
}