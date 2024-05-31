import 'package:flutter/material.dart';
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/Alarm_space.dart';

class BookInfo {
  final String subject;
  final String author;
  final String publishing;

  BookInfo({
    required this.subject,
    required this.author,
    required this.publishing,
  });
}

final List<BookInfo> bookDatas = [
  BookInfo(subject: "공학경제개론", author: "박찬성", publishing: "청람"),
  BookInfo(subject: "대학물리학", author: "Raymond A.Serway", publishing: "북스힐"),
  BookInfo(subject: "해도의 세계사", author: "미아자키 마사카츠", publishing: "어문학사"),
  BookInfo(subject: "기초공학수학", author: "김동식", publishing: "생능"),
  BookInfo(subject: "선형대수학과 응용", author: "이재진", publishing: "경문사"),
  BookInfo(subject: "스튜어트 미분적분학", author: "James Stewart", publishing: "북스힐"),
];

void applyTheme(ThemeData themeData) {
  // 여기에 테마 적용 로직을 추가하세요
  // 현재는 예시로 빈 본문을 추가했습니다
}

class BookList extends StatelessWidget {
  final BookInfo searchResult;

  const BookList({super.key, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(useMaterial3: true);
    final data = getBookListContainsInputSubject();

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    backButton(context: context),
                    const SizedBox(width: 250),
                    alarmCon(context: context),
                  ],
                ),
                searchB(),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return example(data[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget backButton({required BuildContext context}) {
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

  Widget alarmCon({required BuildContext context}) {
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

  Widget searchB() {
    return const SearchBar(
      leading: Icon(Icons.search),
      hintText: "검색어를 입력하세요",
      backgroundColor: MaterialStatePropertyAll(Colors.white70),
    );
  }

  List<BookInfo> getBookListContainsInputSubject() {
    List<BookInfo> findBookList = [];
    for (BookInfo bookInfo in bookDatas) {
      if (bookInfo.subject.contains(searchResult.subject)) {
        findBookList.add(bookInfo);
      }
    }
    return findBookList;
  }

  Widget example(BookInfo data) {
    return Container(
      child: Column(
        children: [
          Text(
            '${data.subject}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '${data.author}',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Text(
            '${data.publishing}',
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const Text(
            '29,000원',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
