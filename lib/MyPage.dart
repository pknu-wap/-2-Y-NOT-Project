import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:flutter_01/Book_SearchList.dart' as BookSearch;
import 'package:flutter_01/WishList.dart';
import 'package:flutter_01/profile.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'), // title 속성 추가
      ),
      body: Center(
        child: Text('This is the chat screen'),
      ),
    );
  }
}


class MyPage extends StatefulWidget {
  final String inputText;

  MyPage({Key? key, this.inputText = ''}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  File? _imageFile; // 선택된 이미지를 저장하는 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                // Handle back button
              },
              child: Icon(Icons.arrow_back_ios_new, color: Colors.grey, size: 24),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '마이페이지',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
              child: Icon(Icons.notifications_none_outlined, color: Color(0xFFFE4D02), size: 32),
            ),
          ],
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Container(
            color: Colors.grey,
            height: 2.0,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildProfileSection(context), // 프로필 섹션 추가
          _buildCategorySection(context),
          _buildPurchaseAndRentalSection(context),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookSearch.BookList(
                    Searchresult: BookSearch.BookInfo(
                      title: '',
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
                context,
                MaterialPageRoute(builder: (context) => MyPage()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_outlined),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      },
      child: Container(
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
                _buildProfileImage(), // 프로필 원형 이미지 추가
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
                _showImagePicker(context); // _getImage에서 _showImagePicker로 수정
              },
              child: Container(
                padding: const EdgeInsets.only(left: 2.0),
                child: const Text(
                  '프로필 수정',
                  style: TextStyle(color: Color(0xFFFE4D02), fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    print(_imageFile);
    return CircleAvatar(
      radius: 26,
      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
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
                  Navigator.pop(context); // 모달 창 닫기
                  _getImage(ImageSource.camera); // 카메라로 이미지 가져오기
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 가져오기'),
                onTap: () {
                  Navigator.pop(context); // 모달 창 닫기
                  _getImage(ImageSource.gallery); // 갤러리에서 이미지 가져오기
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source); // 이미지 가져오기

    // 이미지가 선택되었는지 확인
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _buildMenuItem(
            text: '찜목록',
            onTap: () {
              // 찜목록 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishListForm()),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // 아래 여백 조정
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500), // 텍스트 크기 조정
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: -100.0), // 여백 조정
        onTap: onTap,
      ),
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