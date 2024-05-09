import 'package:flutter/material.dart';
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/Alarm_space.dart';
import 'Searchresult.dart';

class BookList extends StatelessWidget {
  final searchresult Searchresult;

  BookList({Key? key, required this.Searchresult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(useMaterial3: true);
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

  Widget Resultblank() {
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: datas.length,
          itemBuilder: (BuildContext context, int index) {
            final data = datas[index];
            /*bool data.contains(inputText){
              if(true){
                result=data.subject;
              }
              else{
                return null;
              }
            };*/
            //String? result = data.contains(inputText) ? '${data.subject}' : null;
            return Container(
                child: Column(
                  children: [
                    Text(
                        'result',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                    ),
                    Text(
                      '${data.auther}',
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
                ));
          }),
    );
  }
}
