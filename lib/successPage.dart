import 'package:flutter/material.dart';
import 'package:flutter_01/Save_space.dart';

class Main_Page extends StatefulWidget {
  const Main_Page({super.key});

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(useMaterial3: true);
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(children: [
                const SizedBox(width: 270),
                SaveCon(),
                const SizedBox(width: 1),
                AlarmCon(),
                const SizedBox(height: 20),
              ]),
              SearchB(),
              const SizedBox(height: 10),
              Recent_text(),
              Recent_Activity(),
              Find_text(),
              Find_Activity(),
              Realtime_text(),
              Realtime_Activity(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget Recent_text() {
    return TextFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
        labelText: 'User 활동내역',

        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Find_text() {
    return TextFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
        labelText: '찾고 계시는 책이 있나요?',
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Realtime_text() {
    return TextFormField(
      decoration: const InputDecoration(
        border: InputBorder.none,
        labelText: '실시간 최근 올라온 책들',
        labelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Find_Activity() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: RangeMaintainingScrollPhysics(),
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
                  Image.asset('image/picture_3.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
                  Image.asset('image/picture_4.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
                  Image.asset('image/picture_5.png', height: 150, width: 150),
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
              child:
                  Image.asset('image/picture_1.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
                  Image.asset('image/picture_2.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
                  Image.asset('image/picture_3.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
                  Image.asset('image/picture_4.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
                  Image.asset('image/picture_5.png', height: 150, width: 150),
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
                  Image.asset('image/picture_3.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
                  Image.asset('image/picture_4.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
                  Image.asset('image/picture_5.png', height: 150, width: 150),
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
            MaterialPageRoute(builder: (context) => SaveSpace()),
          );
        },
        icon: Icon(Icons.bookmark_outline_outlined));
  }

  Widget SearchB() {
    return SearchBar(leading: Icon(Icons.search));
  }

  Widget SearchCon() {
    return IconButton(
      icon: Icon(Icons.search),
      iconSize: 30,
      onPressed: null,
    );
  }

  Widget AlarmCon() {
    return IconButton(
      icon: Icon(Icons.notifications_none),
      iconSize: 30,
      onPressed: null,
    );
  }
}
