import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_01/Alarm_space.dart';

class PlusCondition {
  final String? price;
  final String? picture;
  List<String>? tags;

  PlusCondition({
    this.price,
    this.picture,
    this.tags,
  });
}

class BookInfo {
  final String title;
  final String author;
  final String publishing;
  final PlusCondition? condition;

  BookInfo({
    required this.title,
    required this.author,
    required this.publishing,
    this.condition,
  });
}

class BookList extends StatelessWidget {
  final BookInfo Searchresult;

  const BookList({super.key, required this.Searchresult});

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    BackButton(context: context),
                    const SizedBox(width: 230),
                    AlarmCon(context: context),
                  ],
                ),
                SearchB(),
                FutureBuilder<List<BookInfo>>(
                  future: searchBooks(Searchresult.title),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No results found');
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // 이 부분 추가
                        shrinkWrap: true,
                        // 이 부분 추가
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
                                        snapshot
                                            .data![index].condition!.picture!,
                                      ),
                                      width: 150,
                                      height: 150,
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                          snapshot.data![index].condition!
                                              .price! +
                                              "원" ??
                                              'No Price Available',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(

                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(width: 600,
                                    child: Divider(color: Colors.black26, thickness: 2.0))
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
        ),
      ),
    );
  }

  Widget BackButton({required BuildContext context}) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      },
      iconSize: 30,
      color: Colors.black,
      icon: const Icon(Icons.arrow_back),
    );
  }

  Widget AlarmCon({required BuildContext context}) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AlarmSpace()),
        );
      },
      iconSize: 30,
      color: Colors.orangeAccent,
      icon: const Icon(Icons.notifications_none),
    );
  }

  Widget SearchB() {
    return const SearchBar(
      leading: Icon(Icons.search),
      hintText: "검색어를 입력하세요",
      backgroundColor: MaterialStatePropertyAll(Colors.white70),
    );
  }
}
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Text('This is the Main Page'),
      ),
    );
  }
}