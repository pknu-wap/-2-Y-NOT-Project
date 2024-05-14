import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/Alarm_space.dart';
import 'Searchresult.dart';

class BookInfo{
  final String subject;
  final String author;
  final String publishing;

  BookInfo({
    required this.subject,
    required this.author,
    required this.publishing,
  });
}

final List<BookInfo> bookDatas =[
  BookInfo(
      subject: "공학경제개론",
      author: "박찬성",
      publishing: "청람"
  ),
  BookInfo(
      subject: "대학물리학",
      author: "Raymond A.Serway",
      publishing: "북스힐"
  ),
  BookInfo(
      subject: "해도의 세계사",
      author: "미아자키 마사카츠",
      publishing: "어문학사"
  ),
  BookInfo(
      subject: "기초공학수학",
      author: "김동식",
      publishing: "생능"
  ),
  BookInfo(
      subject: "선형대수학과 응용",
      author: "이재진",
      publishing: "경문사"
  ),
  BookInfo(
      subject: "스튜어트 미분적분학",
      author: "James Stewart",
      publishing: "북스힐"
  ),
];

class BookList extends StatelessWidget {
  final BookInfo Searchresult;

  BookList({Key? key, required this.Searchresult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(useMaterial3: true);
    final data = GetBookListContainsInputSubject();
    debugPrint(Searchresult.subject);
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
                    const SizedBox(width: 250),
                    AlarmCon(context: context),
                  ],
                ),
                SearchB(),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Example(data[index]);
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
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      },
      iconSize: 30,
      color: Colors.black,
      icon: Icon(Icons.arrow_back),
    );
  }

  Widget AlarmCon({required BuildContext context}) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlarmSpace()),
        );
      },
      iconSize: 30,
      color: Colors.orangeAccent,
      icon: Icon(Icons.notifications_none),
    );
  }

  Widget SearchB() {
    return SearchBar(
        leading: Icon(Icons.search),
        hintText: "검색어를 입력하세요",
        backgroundColor: MaterialStatePropertyAll(Colors.white70));
  }


  List<BookInfo> GetBookListContainsInputSubject() {
    List<BookInfo> findBookList = [];
    for(BookInfo bookInfo in bookDatas) {
      if (bookInfo.subject.contains(Searchresult.subject)){
        findBookList.add(bookInfo);
      }
    }
    return findBookList;
  }


  Widget Example(data) {
    return Container(
      child: Column(
        children: [
          Text(
            '${data.subject}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '${data.author}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Text(
            '${data.publishing}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Text(
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

/*class SearchIf extends StatefulWidget {
  const SearchIf({super.key, required this.books});
  final Books books;
  @override
  State<SearchIf> createState() => _SearchIfState();
}

class _SearchIfState extends State<SearchIf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: Books.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Text(bookData[index].subject),
                leading: SizedBox(
                  child: Text(bookData[index].author),
                ),
              ),
            );
          }
      ),
    );
  }
}*/