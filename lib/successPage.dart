import 'package:flutter/material.dart';
import 'package:flutter_01/Make_BookList.dart';
import 'package:flutter_01/Save_space.dart';
import 'package:flutter_01/Alarm_space.dart';
import 'package:get/get.dart';
import 'package:flutter_01/About Chat/ChatList.dart';
import 'package:flutter_01/Book_SearchList.dart';
import 'MyPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(useMaterial3: true);
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MakeBookList()),);
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orangeAccent,
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(children: [
                const SizedBox(width: 300),
                SaveCon(),
                const SizedBox(width: 1),
                AlarmCon(),
                const SizedBox(height: 20),
              ]),
              SearchB(),
              const SizedBox(height: 10),
              Row(children: [
                Recent_text(),
              ]),
              Recent_Activity(),
              Row(children: [
                Find_text(),
              ]),
              Find_Activity(),
              Row(children: [
                Realtime_text(),
              ]),
              Realtime_Activity(),
            ]),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int wants) {
            switch (wants) {
              case 0:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
                break;
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookList(
                            Searchresult: BookInfo(
                                subject: inputText ?? '',
                                author: '',
                                publishing: ''))));
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatListScreen()),
                );
                break;
              case 3:
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyPage()));
                break;
            }
          },
          items: const [
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
                icon: Icon(
                  Icons.chat,
                ),
                label: '채팅'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: '정보'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget Recent_text() {
    return const Text(
      'User 활동 내역',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 15, // 폰트 크기
        fontWeight: FontWeight.bold, // 폰트 두께
        color: Colors.black, // 폰트 색상
      ),
    );
  }

  Widget Find_text() {
    return const Text(
      '찾고 계시는 책이 있나요?',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 15, // 폰트 크기
        fontWeight: FontWeight.bold, // 폰트 두께
        color: Colors.black, // 폰트 색상
      ),
    );
  }

  Widget Realtime_text() {
    return const Text(
      '실시간 최근 올라온 책들',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 15, // 폰트 크기
        fontWeight: FontWeight.bold, // 폰트 두께
        color: Colors.black, // 폰트 색상
      ),
    );
  }

  Widget Find_Activity() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const RangeMaintainingScrollPhysics(),
      child: Row(
        children: [
          Container(
              child: Image.asset('image/pknu_5.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child: Image.asset('image/pknu_6.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child: Image.asset('image/picture_3.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child: Image.asset('image/picture_4.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child: Image.asset('image/picture_5.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }

  Widget Recent_Activity() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
              child: Image.asset('image/pknu_0.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child: Image.asset('image/pknu_1.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child: Image.asset('image/pknu_2.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child: Image.asset('image/pknu_3.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child: Image.asset('image/pknu_4.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }

  Widget Realtime_Activity() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
              child:
              Image.asset('image/picture_1.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_2.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_3.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_4.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_5.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }

  Widget SaveCon() {
    return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SaveSpace()),
          );
        },
        color: Colors.orangeAccent,
        icon: const Icon(Icons.bookmark_outline_outlined));
  }

  Widget AlarmCon() {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AlarmSpace()),
        );
      },
      icon: const Icon(Icons.notifications_none),
      iconSize: 30,
      color: Colors.orangeAccent,
    );
  }

  List<BookInfo> searchResults = [];

  void searchList(String query) {
    final results = searchResults
        .where((product) => product.subject.contains(query))
        .toList();
    setState(() {
      searchResults = results;
    });
  }

  String? inputText;

  Widget SearchB() {
    return SearchBar(
      onChanged: (value) {
        setState(() => inputText = value);
        //print('Input Text = $inputText');
      },
      leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookList(
                    Searchresult: BookInfo(
                        subject: inputText ?? '', author: '', publishing: '')),
              ),
            );
          }),
      hintText: "검색어를 입력하세요",
      backgroundColor: const MaterialStatePropertyAll(Colors.white70),
    );
  }
}