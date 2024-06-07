import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_01/successPage.dart';
import 'About Chat/ChatList.dart';
import 'BookInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

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

class AlarmPage extends StatelessWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알람'),
      ),
      body: const Center(
        child: Text('알람 페이지'),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final String imageUrl;

  DetailPage({required this.imageUrl});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<String> _dummyText = [''];
  int _currentPage = 0;
  late final PageController _pageController;
  List<bool> isSelected = [false, false, false];
  List<bool> Written = [true, false];
  bool isBookmarked = false;
  List<bool> selectedCondition = [true, false, false];

  List<Widget> conditions = [
    Text('상'),
    Text('중'),
    Text('하'),
  ];

  Future<List<BookInfo>> searchBooksByImage(String query) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('book')
          .where('Image', isEqualTo: query)
          .where('Image', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      List<BookInfo> bookTitles = [];
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        String? bookTitle,
            author,
            publisher,
            postname,
            picture,
            price,
            detail,
            subject;
        Timestamp? time;
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
          } else if (key == "Subject") {
            subject = value;
          } else if (key == "timestamp") {
            time = value;
          } else if (key == "Detail") {
            detail = value;
          } else if (key == "Postname") {
            postname = value;
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
            subject: subject,
            postname: postname,
            detail: detail,
            time: time?.toDate().toString(),
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

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          '상세 정보',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.transparent, // 테두리 색상 없음
                  ),
                ),
                child: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border, // 북마크 상태에 따라 아이콘 변경
                  color: const Color(0xFFFE4D02), // 아이콘 색상 설정
                  size: 24,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlarmPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.notifications_none_outlined,
                  color: Color(0xFFFE4D02),
                  size: 32,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // 매우 작은 높이로 우선 크기 설정
          child: const Divider(
            color: Colors.grey, // 회색 선 색상 설정
            height: 1.0, // 선의 높이 설정
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<List<BookInfo>>(
              future: searchBooksByImage(widget.imageUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('결과 없음');
                } else {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250.0,
                              child: Image.network(
                                snapshot.data![index].condition!.picture!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildPageIndicator(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _dummyText[_currentPage],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  snapshot.data![index].title,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                Text(
                                  snapshot.data![index].condition!.time!,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  snapshot.data![index].condition!.postname!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 2,
                                  color: const Color(0xFFFE4D02),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  snapshot.data![index].condition?.subject ??
                                      'No subject available',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  snapshot.data![index].author,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      snapshot.data![index].publishing,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 200,
                                    ),
                                    Text(
                                      snapshot.data![index].condition!.price! +
                                          "원",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: snapshot.data![index].condition!.tags!
                                      .take(5)
                                      .map((tag) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: Chip(
                                        label: Text(
                                          '#$tag',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFFFE4D02),
                                          ),
                                        ),
                                        shape: const StadiumBorder(
                                          side: BorderSide(
                                            color: Color(0xFFFE4D02),
                                            width: 1.0, // Adjust this value for thickness
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 8),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                                BookVersionSelector(),
                                const SizedBox(height: 8),
                                Handwritten(),
                                const SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '책 상태',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 50),
                                        ToggleButtons(
                                          onPressed: (int index) {
                                            setState(() {
                                              for (int i = 0;
                                              i < selectedCondition.length;
                                              i++) {
                                                selectedCondition[i] = i == index;
                                              }
                                            });
                                          },
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                          selectedBorderColor: Colors.red[700],
                                          selectedColor: Colors.white,
                                          fillColor: Colors.red[200],
                                          color: Colors.red[400],
                                          constraints: const BoxConstraints(
                                            minHeight: 40.0,
                                            minWidth: 80.0,
                                          ),
                                          isSelected: selectedCondition,
                                          children: conditions,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8), // Add SizedBox here
                                    Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8), // Add SizedBox here
                                    Text(
                                      '판매자의 말',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8), // Add SizedBox here
                                    Text(
                                      snapshot.data![index].condition!.detail!,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8), // Add SizedBox here
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                    Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatListScreen()));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                Color(0xFFFE8653),
                                                textStyle: const TextStyle(
                                                    color: Colors.white),
                                                padding: EdgeInsets.only(
                                                    left: 100, right: 100)),
                                            child: const Text('채팅하기',
                                                style: TextStyle(
                                                    color: Colors.white))))
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_dummyText.length, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? const Color(0xFFFE4D02) : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget Handwritten() {
    const List<Widget> uml = <Widget>[
      Text('있음'),
      Text('없음'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '필기 여부',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 30),
          ToggleButtons(
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < Written.length; i++) {
                  if (i == index) {
                    Written[i] = !Written[i];
                  } else {
                    Written[i] = false;
                  }
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: Colors.red[700],
            selectedColor: Colors.white,
            fillColor: Colors.red[200],
            color: Colors.red[400],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: Written,
            children: uml,
          ),
        ],
      ),
    );
  }
}

class BookVersionSelector extends StatefulWidget {
  const BookVersionSelector({Key? key}) : super(key: key);

  @override
  _BookVersionSelectorState createState() => _BookVersionSelectorState();
}

class _BookVersionSelectorState extends State<BookVersionSelector> {
  List<bool> selectedVersion = [true, false];

  @override
  Widget build(BuildContext context) {
    const List<Widget> versions = [
      Text('구판'),
      Text('신판'),
    ];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '구판/신판',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 30),
          ToggleButtons(
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < selectedVersion.length; i++) {
                  selectedVersion[i] = i == index;
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: Colors.red[700],
            selectedColor: Colors.white,
            fillColor: Colors.red[200],
            color: Colors.red[400],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: selectedVersion,
            children: versions,
          ),
        ],
      ),
    );
  }
}
void addBookmarkedBook(BookInfo book) async {
  try {
    // Firestore에 북마크된 책 정보를 저장합니다.
    await FirebaseFirestore.instance.collection('bookmarks').add({
      'title': book.title,
      'author': book.author,
      'publishing': book.publishing,
      // 기타 필요한 필드도 추가할 수 있습니다.
    });
  } catch (error) {
    print('Error adding bookmarked book: $error');
  }
}
Future<List<BookInfo>> getBookmarkedBooks() async {
  List<BookInfo> bookmarkedBooks = [];

  try {
    // Firestore에서 북마크된 책 정보를 가져옵니다.
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bookmarks').get();

    // 가져온 데이터를 BookInfo 객체로 변환하여 리스트에 추가합니다.
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      BookInfo book = BookInfo(
        title: data['title'],
        author: data['author'],
        publishing: data['publishing'],
        // 기타 필요한 필드도 추가할 수 있습니다.
      );
      bookmarkedBooks.add(book);
    });
  } catch (error) {
    print('Error getting bookmarked books: $error');
  }

  return bookmarkedBooks;
}

void addToWishList(List<BookInfo> books) {
  // 가져온 북마크된 책 정보를 위시리스트에 추가합니다.
  // 이 부분에서 위시리스트에 추가하는 로직을 구현하세요.
}
