import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_01/DetailPage.dart'; // DetailPage.dart를 import하여 사용
import 'package:flutter_01/successPage.dart';
import 'Alarm_space.dart';
import 'BookInfo.dart';

// 파라미터로 받은 List를 출력하는 함수 (현재 사용되지 않음)
void printlist(List<String>? parameter) {}

// StatelessWidget을 상속받는 BookList 클래스 정의
class BookList extends StatelessWidget {
  final BookInfo Searchresult;  // 검색 결과로 받은 BookInfo 객체

  // 생성자
  const BookList({super.key, required this.Searchresult});

  // 비동기 함수로 Firestore에서 책 검색
  Future<List<BookInfo>> searchBooks(String query) async {
    try {
      // Firestore에서 책 제목을 기준으로 데이터를 조회
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('book')
          .where('BookTitle', isGreaterThanOrEqualTo: query)
          .where('BookTitle', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      // 결과가 없으면 빈 리스트 반환
      if (snapshot.docs.isEmpty) {
        return [];
      }

      List<BookInfo> bookTitles = [];
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        String? bookTitle, author, publisher, picture, price;
        List<String> tags = [];

        // 문서의 각 필드를 확인하고 필요한 정보 추출
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

        // 추출한 정보로 BookInfo 객체 생성 후 리스트에 추가
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
                    BackButton(context: context),  // 뒤로가기 버튼
                    const SizedBox(width: 230),
                    AlarmCon(context: context),  // 알람 버튼
                  ],
                ),
                SearchB(),
                FutureBuilder<List<BookInfo>>(
                  future: searchBooks(Searchresult.title),  // FutureBuilder를 사용하여 비동기적으로 책 목록 검색
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();  // 로딩 중 표시
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');  // 에러 발생 시 에러 메시지 표시
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No results found');  // 결과가 없을 경우 메시지 표시
                    } else {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var book = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(imageUrl: book.condition?.picture ?? ''),  // DetailPage로 이동
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          if (book.condition?.picture != null &&
                                              book.condition!.picture!.isNotEmpty)
                                            Image(
                                              image: NetworkImage(
                                                book.condition!.picture!,
                                              ),
                                              width: 100,
                                              height: 100,
                                            )
                                          else
                                            Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors.grey,
                                              child: const Icon(Icons.image_not_supported),
                                            ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                book.title,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                book.author,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                book.publishing,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                (book.condition?.price ?? 'No Price Available') + "원",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                              if (book.condition?.tags != null)
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    children: book.condition!.tags!
                                                        .take(3)
                                                        .map((tag) {
                                                      return Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 2),
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
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(color: Colors.black26, thickness: 2.0),
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

  // 뒤로가기 버튼 위젯
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

  // 알람 버튼 위젯
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

  // 검색 바 위젯
  Widget SearchB() {
    return const SearchBar(
      leading: Icon(Icons.search),
      hintText: "검색어를 입력하세요",
      backgroundColor: MaterialStatePropertyAll(Colors.white70),
    );
  }
}
