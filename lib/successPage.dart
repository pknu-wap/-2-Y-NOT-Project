import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_01/DetailPage.dart';
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

  _MainPageState();

  Future<List<BookInfo>> searchBooks(String query) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('book')
          .where('BookTitle', isGreaterThanOrEqualTo: query)
          .where('BookTitle', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      List<BookInfo> bookTitles = [];
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        String? bookTitle, author, publisher, picture, price;
        List<String> tags = [];

        data.forEach((key, value) {
          if (key == "BookTitle") {
            bookTitle = value;
          } else if (key == "Author") {
            author = value;
          } else if (key == "Publisher") {
            publisher = value;
          } else if (key == "Image") {
            picture = value;
          } else if (key == "Price") {
            price = value;
          } else if (key == "Tag") {
            if (value is String) {
              tags.add(value);
            } else {
              for (var tag in value.values) {
                tags.add(tag);
              }
            }
          }
        });

        BookInfo book = BookInfo(
          title: bookTitle ?? " ",
          author: author ?? " ",
          publishing: publisher ?? " ",
          condition: PlusCondition(
            price: price,
            picture: picture,
            tags: tags,
          ),
        );
        bookTitles.add(book);
      }
      return bookTitles;
    } catch (e) {
      print(e);
      return [];
    }
  }

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
          backgroundColor: Colors.orangeAccent,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('book').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              var images = snapshot.data!.docs;
              var Searchresult;
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Row(children: [
                      const SizedBox(width: 200),
                      SaveCon(),
                      const SizedBox(width: 1),
                      AlarmCon(),
                      const SizedBox(height: 20),
                    ]),
                    SearchB(),
                    const SizedBox(height: 10),
                    FutureBuilder<List<BookInfo>>(
                      future: searchBooks(Searchresult.title),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No results found');
                        } else {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Recent_text(),
                                    ]),
                                    Recent_Activity(),
                                    Row(children: [
                                      Find_text(),
                                    ]),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const RangeMaintainingScrollPhysics(),
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('book')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData)
                                            return CircularProgressIndicator();
                                          var images = snapshot.data!.docs;
                                          return GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2),
                                            itemCount: images.length,
                                            itemBuilder: (context, index) {
                                              var image = images[index];
                                              return GestureDetector(
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPage(
                                                            imageId: image.id),
                                                  ),
                                                ),
                                                child: Image.network(
                                                    images[index]['condition']['picture']),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Row(children: [
                                      Realtime_text(),
                                    ]),
                                    Realtime_Activity(),
                                    Container(
                                        width: 600,
                                        child: Divider(
                                            color: Colors.black26,
                                            thickness: 2.0))
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ]),
                ),
              );
            }),
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
                break;
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
      backgroundColor: const MaterialStatePropertyAll(Colors.white70),
    );
  }
}
