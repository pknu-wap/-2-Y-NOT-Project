import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          MyNewHomePage(),
        ]),
      ),
    );
  }
}

class MyNewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFFFE4D02)),
          child: Stack(
            children: [
              Positioned(
                left: -35,
                top: -66,
                child: Container(
                  width: 430,
                  height: 932,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Color(0xFFFE4D02)),
                  child: Stack(
                    children: [
                      Positioned(
                        left: -216,
                        top: 125,
                        child: Container(
                          width: 91.20,
                          height: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("https://file.notion.so/f/f/294691e0-1a03-4716-8c7d-b435ebc955b4/9dff7caa-578b-4602-85ed-392c2bca24de/Untitled.png?id=7943561c-ac99-491b-9c35-d807b6ff64c1&table=block&spaceId=294691e0-1a03-4716-8c7d-b435ebc955b4&expirationTimestamp=1717761600000&signature=S5fXeW5eZmwpXlANmOWZftV_lwNlCJKgMcXHTcKvpOY&downloadName=Untitled.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 175,
                        top: 812,
                        child: Text(
                          'Y-NOT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 281,
                        top: 267,
                        child: Container(
                          width: 100,
                          height: 100,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                        ),
                      ),
                      Positioned(
                        left: 118,
                        top: 606,
                        child: Container(
                          width: 194,
                          height: 46,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFE8552),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 118,
                        top: 675,
                        child: Container(
                          width: 194,
                          height: 46,
                          decoration: ShapeDecoration(
                            color: Color(0xFFFE8653),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 148,
                        top: 743,
                        child: Text(
                          '로그인 없이 구경하기',
                          style: TextStyle(
                            color: Color(0xFFF9F2F2),
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: -56,
                        top: 125,
                        child: Container(
                          width: 500,
                          height: 347.46,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("https://file.notion.so/f/f/294691e0-1a03-4716-8c7d-b435ebc955b4/9dff7caa-578b-4602-85ed-392c2bca24de/Untitled.png?id=7943561c-ac99-491b-9c35-d807b6ff64c1&table=block&spaceId=294691e0-1a03-4716-8c7d-b435ebc955b4&expirationTimestamp=1717761600000&signature=S5fXeW5eZmwpXlANmOWZftV_lwNlCJKgMcXHTcKvpOY&downloadName=Untitled.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 437,
                        child: Column(
                          children: [
                            Image.file(
                              File("https://file.notion.so/f/f/294691e0-1a03-4716-8c7d-b435ebc955b4/9dff7caa-578b-4602-85ed-392c2bca24de/Untitled.png?id=7943561c-ac99-491b-9c35-d807b6ff64c1&table=block&spaceId=294691e0-1a03-4716-8c7d-b435ebc955b4&expirationTimestamp=1717761600000&signature=S5fXeW5eZmwpXlANmOWZftV_lwNlCJKgMcXHTcKvpOY&downloadName=Untitled.png"),
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              'BOOking',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 150,
                top: 555,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        '회원가입',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
