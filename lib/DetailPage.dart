import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_01/successPage.dart';
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

class DetailPage extends StatelessWidget {
  final String imageUrl;
  final List<String> _dummyText = [''];
  int _currentPage = 0;
  late final PageController _pageController;
  List<bool> isSelected = [false, false, false];
  List<bool> Written = [false, false];

  DetailPage({required this.imageUrl});

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlarmPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Color(0xFFFE4D02),
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<List<BookInfo>>(
              future: searchBooksByImage(imageUrl),
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
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image(
                                  image: NetworkImage(
                                    snapshot.data![index].condition!.picture!,
                                  ),
                                  width: 150,
                                  height: 150,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].title,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data![index].author,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data![index].publishing,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${snapshot.data![index].condition!.price!}원" ??
                                          'No Price Available',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (snapshot.data![index].condition?.tags != null)
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: snapshot.data![index].condition!.tags!
                                    .map((tag) {
                                  return Chip(
                                    label: Text(tag),
                                  );
                                }).toList(),
                              ),
                            Container(
                                width: 600,
                                child: Divider(
                                    color: Colors.black26, thickness: 2.0)),
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

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: const Color(0xFFFE4D02),
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFFE4D02),
          fontWeight: FontWeight.bold,
        ),
      ),
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

  void setState(Null Function() param0) {}
}

class BookVersionSelector extends StatefulWidget {
  const BookVersionSelector({Key? key}) : super(key: key);

  @override
  _BookVersionSelectorState createState() => _BookVersionSelectorState();
}

class _BookVersionSelectorState extends State<BookVersionSelector> {
  List<bool> selectedVersion = [false, false];

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

class BookCondition extends StatefulWidget {
  const BookCondition({Key? key}) : super(key: key);

  @override
  _BookConditionState createState() => _BookConditionState();
}

class _BookConditionState extends State<BookCondition> {
  List<bool> selectedCondition = [false, false, false];

  @override
  Widget build(BuildContext context) {
    const List<Widget> conditions = [
      Text('상'),
      Text('중'),
      Text('하'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '책 상태',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 50),
              ToggleButtons(
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < selectedCondition.length; i++) {
                      selectedCondition[i] = i == index;
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
            '이 책은 2023년도에 구입하여 사용한 책입니다. '
                '약간의 사용감이 있으나 대체로 상태는 양호합니다.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8), // Add SizedBox here
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          BookCondition(), // Add BookCondition widget
        ],
      ),
    );
  }
}