import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_01/Make_BookList.dart';
import 'package:flutter_01/Save_space.dart';
import 'package:flutter_01/Alarm_space.dart';
import 'package:get/get.dart';
import 'package:flutter_01/About Chat/ChatList.dart';
import 'package:flutter_01/Book_SearchList.dart';
import 'DetailPage.dart';
import 'dart:math';
import 'BookInfo.dart';
import 'MyPage.dart';
import 'package:google_fonts/google_fonts.dart';

class App{
  App._();
  static TextTheme get font => GoogleFonts.gamjaFlowerTextTheme();
}

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MakeBookList()),
            );
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFFFE4D02),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(children: [
              const SizedBox(width: 250),
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
                                title: inputText ?? '',
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
                icon: Icon(Icons.account_circle), label: '정보'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget Recent_text() {
    return Text(
      'User 활동 내역',
      textAlign: TextAlign.left,
      style: GoogleFonts.gamjaFlower(
        fontSize: 25, // 폰트 크기
        fontWeight: FontWeight.bold, // 폰트 두께
        color: Colors.black,
      ),
    );
  }

  Widget Find_text() {
    return Text(
      '찾고 계시는 책이 있나요?',
      textAlign: TextAlign.left,
      style: GoogleFonts.gamjaFlower(
        fontSize: 25, // 폰트 크기
        fontWeight: FontWeight.bold, // 폰트 두께
        color: Colors.black,
      ),
    );
  }

  Widget Realtime_text() {
    return Text(
      '실시간 최근 올라온 책들',
      textAlign: TextAlign.left,
      style: GoogleFonts.gamjaFlower(
        fontSize: 25, // 폰트 크기
        fontWeight: FontWeight.bold, // 폰트 두께
        color: Colors.black,
      ),
    );
  }

  Widget Find_Activity() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('book').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          var images = snapshot.data!.docs;
          var random = Random();
          var selectedImages = images..shuffle(random);
          selectedImages = selectedImages.take(4).toList();

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
            children: List.generate(selectedImages.length, (index) {
              var image = selectedImages[index];
              var imageUrl = image['Image'];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(imageUrl: imageUrl),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(8.0), // 여백을 추가하여 이미지 간격 조정
                  child: Image.network(
                    imageUrl,
                    width: 150, // 이미지의 너비를 설정합니다.
                    height: 200, // 이미지의 높이를 설정합니다.
                  ),
                ),
              );
            }),
            ),
            );
          },
          );
        }

  Widget Recent_Activity() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('book').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        var images = snapshot.data!.docs;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(4, (index) {
              var image = images[index];
              var imageUrl = image['Image'];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(imageUrl: imageUrl),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(8.0), // 여백을 추가하여 이미지 간격 조정
                  child: Image.network(
                    imageUrl,
                    width: 150, // 이미지의 너비를 설정합니다.
                    height: 200, // 이미지의 높이를 설정합니다.
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }



  Widget Realtime_Activity() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('book')
          .orderBy('timestamp', descending: true) // '등록한 시간' 필드를 기준으로 내림차순 정렬
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        var images = snapshot.data!.docs;
        var selectedImages = images.take(4).toList(); // 최신순으로 정렬된 데이터 중 상위 4개를 선택

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(selectedImages.length, (index) {
              var image = selectedImages[index];
              var imageUrl = image['Image'];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(imageUrl: imageUrl),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all(8.0), // 여백을 추가하여 이미지 간격 조정
                  child: Image.network(
                    imageUrl,
                    width: 150, // 이미지의 너비를 설정합니다.
                    height: 200, // 이미지의 높이를 설정합니다.
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
  Color blendWithWhite(Color color, double factor) {
    assert(factor >= 0.0 && factor <= 1.0);

    int red = (color.red + (255 - color.red) * factor).toInt();
    int green = (color.green + (255 - color.green) * factor).toInt();
    int blue = (color.blue + (255 - color.blue) * factor).toInt();

    return Color.fromARGB(color.alpha, red, green, blue);
  }
  Widget SaveCon() {
    return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SaveSpace()),
          );
        },
        color: Color(0xFFFE4D02),
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
      color: Color(0xFFFE4D02),
    );
  }

  List<BookInfo> searchResults = [];

  void searchList(String query) {
    final results = searchResults
        .where((product) => product.title.contains(query))
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
                        title: inputText ?? '', author: '', publishing: '')),
              ),
            );
          }),
      hintText: "검색어를 입력하세요",
      backgroundColor: MaterialStateProperty.all(blendWithWhite(Color(0xFFFE4D02), 0.7)),
    );
  }
}
