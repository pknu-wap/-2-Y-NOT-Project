import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            // 위젯 추가 가능
          ],
        ),
      ),
    );
  }
}

class WishListForm extends StatefulWidget {
  @override
  _WishListFormState createState() => _WishListFormState();
}

class _WishListFormState extends State<WishListForm> {
  TextEditingController _itemController = TextEditingController();
  List<BookInfo> _bookmarkedBooks = []; // 북마크된 책 목록

  // 위시리스트에 북마크된 책을 추가하는 메서드
  void addToWishList(List<BookInfo> books) {
    setState(() {
      _bookmarkedBooks.addAll(books); // 북마크된 책 목록에 추가
    });
  }

  @override
  void initState() {
    super.initState();
    _loadBookmarkedBooks(); // 위시리스트 초기화 시 북마크된 데이터 로드
  }

  Future<void> _loadBookmarkedBooks() async {
    try {
      // Firebase 초기화 코드
      // QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bookmark').get();
      // setState(() {
      //   _bookmarkedBooks = snapshot.docs.map((doc) => BookInfo.fromMap(doc.data())).toList();
      // });
    } catch (error) {
      print("Error loading bookmarked books: $error");
    }
  }

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
                itemCount: _bookmarkedBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  final bookmarkedBook = _bookmarkedBooks[index];
                  return ListTile(
                    title: Text(bookmarkedBook.title),
                    subtitle: Text('${bookmarkedBook.author}, ${bookmarkedBook.publishing}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await _removeBookmarkedBook(bookmarkedBook);
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

  Future<void> _removeBookmarkedBook(BookInfo book) async {
    try {
      // Firebase 삭제 코드
      // await FirebaseFirestore.instance.collection('bookmark').doc(book.id).delete();
      setState(() {
        _bookmarkedBooks.remove(book);
      });
      // 삭제 완료 메시지 등 추가할 수 있음
    } catch (error) {
      print("Error removing bookmarked book: $error");
      // 오류 메시지 표시 등의 처리 추가 가능
    }
  }
}

// 임시 페이지 클래스 정의
class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text('Notifications Page'),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Text('Main Page'),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: Center(
        child: Text('Chat Page'),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Center(
        child: Text('My Page'),
      ),
    );
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // 위시리스트 폼의 상태 인스턴스 생성
  _WishListFormState wishListFormState = _WishListFormState();

  // 북마크된 책 정보를 가져옵니다.
  List<BookInfo> bookmarkedBooks = await getBookmarkedBooks();

  // 위시리스트에 북마크된 책을 추가합니다.
  wishListFormState.addToWishList(bookmarkedBooks);

  runApp(MyApp());
}

Future<List<BookInfo>> getBookmarkedBooks() async {
  // 북마크된 책 정보를 가져오는 비동기 로직을 구현합니다.
  // 이 예시에서는 임시적으로 빈 리스트를 반환합니다.
  return [];
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Center(
          child: Text('Welcome to my app!'),
        ),
      ),
    );
  }
}
