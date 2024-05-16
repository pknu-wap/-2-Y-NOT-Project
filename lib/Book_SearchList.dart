import 'package:flutter/material.dart';
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/Alarm_space.dart';

class BookList extends StatelessWidget {
  const BookList({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(useMaterial3: true);
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
                //Text("here")
                Resultblank(),
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
          MaterialPageRoute(builder: (context) => const Main_Page()),
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
        backgroundColor: MaterialStatePropertyAll(Colors.white70));
  }

  Widget Resultblank() {
    return Container(
        child: Row(
            children: [
              Image.asset('image/picture_1.png', height: 150, width: 150),
              const SizedBox(width: 20),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '공학경제개론',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '박찬석, 최성호 저자(글)',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '청람',
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
                    Row(
                      children: [
                        Text(
                          '#쑤박',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    const Icon(Icons.bookmark_outline_outlined,
                        color: Colors.orangeAccent);
                  },
                  icon: const Icon(Icons.bookmark_outline_outlined)),
            ],
          ),
        );
  }
}
