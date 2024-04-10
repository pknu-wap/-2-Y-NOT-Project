import 'package:flutter/material.dart';

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
        body: ListView(
          children: const [
            MyCustomWidget(), // 사용자 정의 위젯을 ListView의 자식으로 추가
          ],
        ),
      ),
    );
  }
}

class MyCustomWidget extends StatelessWidget {
  const MyCustomWidget({Key? key}) : super(key: key); // 생성자에 const 추가

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 360,
          height: 800,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFFFE4D02)),
          child: Stack(
            children: [
              Positioned(
                left: -35,
                top: -66,
                child: Container(
                  width: 430,
                  height: 932,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(color: Color(0xFFFE4D02)),
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
                              image: NetworkImage("https://via.placeholder.com/91x120"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 175,
                        top: 812,
                        child: const Text(
                          'Y-NOT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 437,
                        child: const Text(
                          'BOOking',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
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
                              borderRadius: BorderRadius.circular(50), // const 제거
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
                              borderRadius: BorderRadius.circular(50), // const 제거
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 148,
                        top: 743,
                        child: const Text(
                          '로그인 없이 구경하기',
                          style: TextStyle(
                            color: Color(0xFFF9F2F2),
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      // 다른 Positioned 위젯들을 필요에 따라 추가
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 150,
                top: 555,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      '회원가입',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
//안녕