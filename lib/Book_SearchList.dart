import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/Alarm_space.dart';

class Booklist extends StatelessWidget {
  final BuildContext context;
  Booklist({required this.context});
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
                    AlarmCon(context: context),
                  ],
                ),
                SearchB(),

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
          MaterialPageRoute(builder: (context) => Main_Page()),
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

  Widget Resultblank(){
    return Scaffold(

    );
  }
}
