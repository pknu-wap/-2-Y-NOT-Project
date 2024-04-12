import 'package:flutter/material.dart';
import 'user.dart';

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
          margin: const EdgeInsets.only(top:50),
          padding: const EdgeInsets.all(10.0),
          child: SearchBar(
            trailing:[Icon(Icons.search)]
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [

              ],
            ),
          ),
        ),
      ),
    );
  }

}