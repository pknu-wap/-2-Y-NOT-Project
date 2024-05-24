import 'package:flutter/material.dart';
import 'package:get/get.dart'; // GetX 패키지를 사용하는 경우 추가
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/chat.dart';
import 'package:flutter_01/Make_BookList.dart';
import 'package:flutter_01/MyPage.dart';

class WishListForm extends StatefulWidget {
  @override
  _WishListFormState createState() => _WishListFormState();
}

class _WishListFormState extends State<WishListForm> {
  final TextEditingController _itemController = TextEditingController();
  List<WishItem> _wishList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '위시리스트',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFE4D02), // 상단바 배경색 설정
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: '항목 추가',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addItemToList();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _wishList.where((item) => item.isBookmarked).length,
              itemBuilder: (BuildContext context, int index) {
                final bookmarkedItems =
                _wishList.where((item) => item.isBookmarked).toList();
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  title: Center(
                    child: Text(
                      bookmarkedItems[index].name,
                      style: TextStyle(
                        color: Colors.black87, // 기본 텍스트 색상으로 수정
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _removeItemFromList(bookmarkedItems[index]);
                    },
                  ),
                  leading: IconButton(
                    icon: Icon(bookmarkedItems[index].isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border),
                    onPressed: () {
                      _toggleBookmark(bookmarkedItems[index]);
                    },
                  ),
                );
              },
            ),
          ),
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
                      builder: (context) => BookList(
                          searchResult: BookInfo(
                              subject: '', // 검색어를 빈 문자열로 설정 (필요에 따라 수정)
                              author: '',
                              publishing: ''))));
              break; // break 추가
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

  void _addItemToList() {
    setState(() {
      String newItem = _itemController.text.trim();
      if (newItem.isNotEmpty) {
        _wishList.add(WishItem(name: newItem));
        _itemController.clear();
      }
    });
  }

  void _removeItemFromList(WishItem item) {
    setState(() {
      _wishList.remove(item);
    });
  }

  void _toggleBookmark(WishItem item) {
    setState(() {
      item.isBookmarked = !item.isBookmarked;
    });
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }
}

class WishItem {
  String name;
  bool isBookmarked;

  WishItem({required this.name, this.isBookmarked = false});
}

void main() {
  runApp(MaterialApp(
    home: WishListForm(),
  ));
}
