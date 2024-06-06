import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅창'),
      ),
      body: const Center(
        child: Text('채팅창'),
      ),
    );
  }
}

class AlarmPage extends StatelessWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알람'),
      ),
      body: const Center(
        child: Text('알람 페이지'),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<String> _dummyText = [''];
  int _currentPage = 0;
  late final PageController _pageController;
  List<bool> isSelected = [false, false, false];
  List<bool> Written = [false, false];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          '상세 정보',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlarmPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Color(0xFFFE4D02),
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 250.0,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _dummyText.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://via.placeholder.com/350',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              _buildPageIndicator(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _dummyText[_currentPage],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '닉네임',
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    '2024.03.03',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '선형대수',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 2,
                    color: const Color(0xFFFE4D02),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '공학이론',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '저자',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '청람',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildTag('#쑤박'),
                      const SizedBox(width: 4),
                      _buildTag('#에누리 가능'),
                      const SizedBox(width: 4),
                      _buildTag('#부경대 후문'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  BookVersionSelector(),
                  const SizedBox(height: 8),
                  Handwritten(),
                  const SizedBox(height: 16),
                  BookCondition(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFE4D02),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const SizedBox(
            width: double.infinity,
            child: Text(
              '채팅 하기',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_dummyText.length, (index) {
        return Container(
          width : 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? const Color(0xFFFE4D02) : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: const Color(0xFFFE4D02),
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFFE4D02),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Handwritten() {
    const List<Widget> uml = <Widget>[
      Text('있음'),
      Text('없음'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '필기 여부',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 30),
          ToggleButtons(
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < Written.length; i++) {
                  if (i == index) {
                    Written[i] = !Written[i];
                  } else {
                    Written[i] = false;
                  }
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: Colors.red[700],
            selectedColor: Colors.white,
            fillColor: Colors.red[200],
            color: Colors.red[400],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: Written,
            children: uml,
          ),
        ],
      ),
    );
  }
}

class BookVersionSelector extends StatefulWidget {
  const BookVersionSelector({Key? key}) : super(key: key);

  @override
  _BookVersionSelectorState createState() => _BookVersionSelectorState();
}

class _BookVersionSelectorState extends State<BookVersionSelector> {
  List<bool> selectedVersion = [false, false];

  @override
  Widget build(BuildContext context) {
    const List<Widget> versions = [
      Text('구판'),
      Text('신판'),
    ];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '구판/신판',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 30),
          ToggleButtons(
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < selectedVersion.length; i++) {
                  selectedVersion[i] = i == index;
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: Colors.red[700],
            selectedColor: Colors.white,
            fillColor: Colors.red[200],
            color: Colors.red[400],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: selectedVersion,
            children: versions,
          ),
        ],
      ),
    );
  }
}

class BookCondition extends StatefulWidget {
  const BookCondition({Key? key}) : super(key: key);

  @override
  _BookConditionState createState() => _BookConditionState();
}

class _BookConditionState extends State<BookCondition> {
  List<bool> selectedCondition = [false, false, false];

  @override
  Widget build(BuildContext context) {
    const List<Widget> conditions = [
      Text('상'),
      Text('중'),
      Text('하'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '책 상태',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 50),
              ToggleButtons(
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < selectedCondition.length; i++) {
                      selectedCondition[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                fillColor: Colors.red[200],
                color: Colors.red[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
                isSelected: selectedCondition,
                children: conditions,
              ),
            ],
          ),
          SizedBox(height: 8), // Add SizedBox here
          Container(
            height: 1,
            color: Colors.grey,
          ),
          SizedBox(height: 8), // Add SizedBox here
          Text(
            '판매자의 말',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8), // Add SizedBox here
          Text(
            '이 책은 2023년도에 구입하여 사용한 책입니다. '
                '약간의 사용감이 있으나 대체로 상태는 양호합니다.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8), // Add SizedBox here
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          BookCondition(), // Add BookCondition widget
        ],
      ),
    );
  }
}
