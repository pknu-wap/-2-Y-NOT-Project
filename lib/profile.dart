import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import the dart:io library for File class
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_01/successPage.dart';
import 'package:flutter_01/MyPage.dart';
import 'package:flutter_01/Book_SearchList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> _changeProfileImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await _uploadProfileImage(imageFile);
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _uploadProfileImage(File file) async {
    try {
      await storage.ref('profile_images/${file.path.split('/').last}').putFile(file);
    } on FirebaseException catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<String?> _getProfileImageUrl() async {
    try {
      String downloadURL = await storage.ref('profile_images/${_imageFile?.name}').getDownloadURL();
      return downloadURL;
    } catch (e) {
      // Handle error
      return null;
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('카메라로 찍기'),
                onTap: () {
                  Navigator.of(context).pop();
                  _changeProfileImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('갤러리에서 열기'),
                onTap: () {
                  Navigator.of(context).pop();
                  _changeProfileImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  const Text(
                    '프로필',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    child: const Icon(Icons.notifications_none_outlined, color: Color(0xFFFE4D02), size: 32),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotificationsPage()),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 8), // 상단바 위 여백을 늘리기 위해 추가
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const SizedBox(width: 36),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () => _showImageSourceActionSheet(context),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 50,
                          backgroundImage: _imageFile == null
                              ? null
                              : FileImage(File(_imageFile!.path)),
                          child: _imageFile == null
                              ? Icon(Icons.person, color: Colors.white, size: 50)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _showImageSourceActionSheet(context),
                          child: Container(
                            width: 36,
                            height: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xFFDEDEDE),
                            ),
                            child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 24),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFFE4D02),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('초보판매자', style: TextStyle(color: Colors.white, fontSize: 13)),
                      ),
                      const SizedBox(height: 8),
                      const Text('닉네임', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 24),
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.centerLeft,
                color: const Color(0xFFDFDFDF),
                child: const Text('가입일 2024.01.01', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFDFDF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFFE4D02),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                bottom: -25,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  alignment: Alignment.center,
                                  child: const Text('초보판매자', style: TextStyle(color: Colors.black, fontSize: 16)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  const SizedBox(width: 36),
                  const Text('판매도서 ', style: TextStyle(color: Colors.black, fontSize: 18,)),
                  const Text('2권', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 36),
                  const Text('받은 거래 후기 ', style: TextStyle(color: Colors.black, fontSize: 18,)),
                  const Text('1회', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  String? url = await _getProfileImageUrl();
                  if (url != null) {
                    print('Profile Image URL: $url');
                  }
                },
                child: Text('Get Profile Image URL'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
      switch (index) {
      case 0:
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      break;
      case 1:
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => BookList(
      Searchresult: BookInfo(
      title:'',
      author: '',
      publishing: '')))
      );
      break;
      case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
      break;
      case 3:
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
      break;
      }
        },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.add_outlined), label: '판매'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '정보'),
          ],
          type: BottomNavigationBarType.fixed,
        ),
    );
  }
}

Widget _buildMenuItem({required String text, required VoidCallback onTap}) {
  return ListTile(
    title: Text(text),
    onTap: onTap,
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
      ),
      body: const Center(
        child: Text('홈 페이지'),
      ),
    );
  }
}

class SalesPage extends StatelessWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('판매'),
      ),
      body: const Center(
        child: Text('판매 페이지'),
      ),
    );
  }
}

class RentalPage extends StatelessWidget {
  const RentalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('대여'),
      ),
      body: const Center(
        child: Text('대여 페이지'),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅'),
      ),
      body: const Center(
        child: Text('채팅 페이지'),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림페이지'),
      ),
      body: const Center(
        child: Text(' '),
      ),
    );
  }
}

class BookInfo {
  final String title;
  final String author;
  final String publishing;

  BookInfo({required this.title, required this.author, required this.publishing});
}

class BookList extends StatelessWidget {
  final BookInfo Searchresult;

  const BookList({Key? key, required this.Searchresult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도서 목록'),
      ),
      body: const Center(
        child: Text('도서 목록 페이지'),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보'),
      ),
      body: const Center(
        child: Text('내 정보 페이지'),
      ),
    );
  }
}
