import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // ImagePicker 패키지 추가

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '마이페이지',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 이전 페이지로 이동
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // 오른쪽에 약간의 패딩 추가
            child: IconButton(
              icon: Icon(Icons.notifications, color: Color(0xFFFE4D02)), // 아이콘 색상 변경
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()), // 알림 페이지로 이동
                );
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
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
        bottomNavigationBar: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // 하단바 주변의 배경색 설정
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // 그림자 효과 추가
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 1), // 그림자 위치 설정
                ),
              ],
            ),
            height: 80.0, // 하단바의 높이를 더 크게 설정
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavBarItem(Icons.home, '홈', () {
                  // 홈 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }),
                _buildNavBarItem(Icons.shopping_bag, '판매', () {
                  // 판매 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SalesPage()),
                  );
                }),
                _buildNavBarItem(Icons.receipt, '대여', () {
                  // 대여 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RentalPage()),
                  );
                }),
                _buildNavBarItem(Icons.chat, '채팅', () {
                  // 채팅 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage()),
                  );
                }),
                _buildNavBarItem(Icons.info, '정보', () {
                  // 정보 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPage()),
                  );
                }),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(10.0),
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
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFFE4D02),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      '초보판매자',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '닉네임',
                    style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 1.0),
          GestureDetector(
            onTap: () {
              _showImagePicker(context); // 프로필 수정 텍스트를 눌렀을 때 모달창을 열어줍니다.
            },
            child: Container(
              padding: EdgeInsets.only(left: 4.0), // 왼쪽 여백 추가
              child: Text(
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
                leading: Icon(Icons.camera_alt),
                title: Text('카메라로 찍기'),
                onTap: () {
                  _getImage(context, ImageSource.camera); // 카메라로 이미지 가져오기
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('갤러리에서 가져오기'),
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

    // 여기에 이미지를 가져온 후의 처리를 추가하세요
  }

// 나머지 메서드는 생략...
}

// 하단바 아이템 페이지들은 이전과 동일합니다.

Widget _buildCategorySection(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
              MaterialPageRoute(builder: (context) => SalesHistoryPage()),
            );
          },
        ),
        _buildMenuItem(
          text: '대여 내역',
          onTap: () {
            // 대여내역 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RentalHistoryPage()),
            );
          },
        ),
        _buildMenuItem(
          text: '후기',
          onTap: () {
            // 후기 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReviewsPage()),
            );
          },
        ),
        _buildMenuItem(
          text: '내 상품 관리',
          onTap: () {
            // 내 상품 관리 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyItemsManagementPage()),
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildPurchaseAndRentalSection(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
              MaterialPageRoute(builder: (context) => WishListPage()),
            );
          },
        ),
        _buildMenuItem(
          text: '구매 내역',
          onTap: () {
            // 구매 내역 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PurchaseHistoryPage()),
            );
          },
        ),
        _buildMenuItem(
          text: '최근 본 상품',
          onTap: () {
            // 최근 본 상품 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecentlyViewedItemsPage()),
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

Widget _buildNavBarItem(IconData icon, String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(height: 4.0),
        Text(
          text,
          style: TextStyle(fontSize: 12.0),
        ),
      ],
    ),
  );
}

// 각각의 하단바 아이템에 해당하는 페이지들을 추가합니다.

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈'),
      ),
      body: Center(
        child: Text('홈 페이지'),
      ),
    );
  }
}

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('판매'),
      ),
      body: Center(
        child: Text('판매 페이지'),
      ),
    );
  }
}

class RentalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('대여'),
      ),
      body: Center(
        child: Text('대여 페이지'),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅'),
      ),
      body: Center(
        child: Text('채팅 페이지'),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림페이지'),
      ),
      body: Center(
        child: Text(' '),
      ),
    );
  }
}

class SalesHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('판매 내역'),
      ),
      body: Center(
        child: Text(' '),
      ),
    );
  }
}

class RentalHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('대여 내역'),
      ),
      body: Center(
        child: Text(' '),
      ),
    );
  }
}

class ReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('후기'),
      ),
      body: Center(
        child: Text(' '),
      ),
    );
  }
}

class MyItemsManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 상품 관리'),
      ),
      body: Center(
        child: Text(' '),
      ),
    );
  }
}

class WishListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('찜 목록'),
      ),
      body: Center(
        child: Text(' '),
      ),
    );
  }
}

class PurchaseHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('구매 내역'),
      ),
      body: Center(
        child: Text(' '),
      ),
    );
  }
}

class RecentlyViewedItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('최근 본 상품'),
      ),
      body: Center(
        child: Text(' '),
      ),
    );
  }
}
