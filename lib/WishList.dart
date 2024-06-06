import 'package:flutter/material.dart';
import 'package:get/get.dart'; // GetX 패키지를 사용하는 경우 추가
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/Book_SearchList.dart';
import 'package:flutter_01/MyPage.dart';

class BookInfo {
  final String title;
  final String author;
  final String publishing;

  BookInfo({required this.title, required this.author, required this.publishing});
}

class BookList extends StatelessWidget {
  final BookInfo searchResult;

  BookList({required this.searchResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
      ),
      body: Center(
        child: Text('Displaying books based on search result'),
      ),
    );
  }
}

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 16),
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.grey,
                    size: 24,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                const Text(
                  '위시 리스트',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                GestureDetector(
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    color: Color(0xFFFE4D02),
                    size: 32,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationsPage()),
                    );
                  },
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 8), // 상단바 위 여백을 늘리기 위해 추가
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _wishList.where((item) => item.isBookmarked).length,
                itemBuilder: (BuildContext context, int index) {
                  final bookmarkedItems = _wishList.where((item) => item.isBookmarked).toList();
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    title: Center(
                      child: Text(
                        bookmarkedItems[index].name,
                        style: TextStyle(color: Colors.black87),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
              // Navigate to main page
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookList(
                    searchResult: BookInfo(
                      title: '', // 필요한 정보를 여기에 제공하세요
                      author: '',
                      publishing: '',
                    ),
                  ),
                ),
              );
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
              // Navigate to MyPage
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.add_outlined), label: '판매'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '정보'),
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

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Center(
        child: Text('Chat with others here'),
      ),
    );
  }
}
