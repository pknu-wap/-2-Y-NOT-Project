import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_01/successPage.dart';

class MakeBookList extends StatefulWidget {
  @override
  State<MakeBookList> createState() => _MakeBookListState();
}

class _MakeBookListState extends State<MakeBookList> {

  final _controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String? _BookTitle; //책이름
  String? _Bookauthor; //저자
  String? _Publisher; //출판사
  String? _Subject; //과목명
  String? _Quality; //책상태
  bool? _Takenote; //필기여부
  String? _Postname; //제목
  String? _Price; //가격
  String? _Detail; //자세한 설명
  String? _MeetingPlace; //거래희망장소
  String? _Tag1; //해시태그1
  String? _Tag2; //해시태그2
  String? _Tag3; //해시태그3
  String? _Tag4; //해시태그4
  String? _Tag5; //해시태그5
  final Written = <bool>[true, false];
  final isSelectedd = <bool>[true, false, false];
  final picker = ImagePicker();
  XFile? image;
  List<XFile?> multiImage = [];
  List<XFile?> images = [];
  String? inputText;
  String? ttag;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void saveText() {
    if (Written[0] == true)
      _Takenote = true;
    else
      _Takenote = false;

    for (int i = 0; i < 2; i++) {
      if (isSelectedd[i] == true) {
        int j = i;
        if (i == 0)
          _Quality = '상';
        else if (i == 1)
          _Quality = '중';
        else
          _Quality = '하';
      }
    }
    _controller.text = _controller.text.trim();
    if (_controller.text.isNotEmpty) {
      DivideTag();
      FirebaseFirestore.instance.collection('book').add({
        'BookTitle': _BookTitle,
        'Author': _Bookauthor,
        'Publisher': _Publisher,
        'Subject': _Subject,
        'Quality': _Quality,
        'TakeNote': _Takenote,
        'Postname': _Postname,
        'Price': _Price,
        'Detail': _Detail,
        'MeetingPlace': _MeetingPlace,
        'Tag': {
          '1Tag': _Tag1,
          '2Tag': _Tag2,
          '3Tag': _Tag3,
          '4Tag': _Tag4,
          '5Tag': _Tag5
        },
        'Seller': loggedInUser!.email,
        'timestamp': Timestamp.now(),
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('판매'),
          centerTitle: true,
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,//가운데 정렬
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CameraButton(),
                    AddPictureButton(),
                  ],
                ),
                //Expanded(child: ShowPicture()),
                Center(child: AboutText()),
                BasicInformation(),
                BookCondition(),
                Handwritten(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    TitleT(),
                    const SizedBox(width: 20),
                  ],
                ),
                Center(child: TitleF()),
                Row(
                  children: [
                    PriceT(),
                    const SizedBox(width: 20),
                  ],
                ),
                Center(child: PriceF()),
                Row(
                  children: [
                    DetailExplanationT(),
                    const SizedBox(width: 20),
                  ],
                ),
                Center(child: DetailExplanationF()),
                Row(
                  children: [
                    WantPlaceT(),
                    const SizedBox(width: 20),
                  ],
                ),
                Center(child: WantPlaceF()),
                Row(
                  children: [
                    HashtagT(),
                    const SizedBox(width: 20),
                  ],
                ),
                Center(child: HashtagF()),
                Center(child: complete()),
              ],
            ),
          ),
        ));
  }

  Widget AboutText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('책에 대한 정보',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Widget MakeNameT() {
    return Text('책 이름');
  }

  Widget MakeAuthorT() {
    return Text('저자 ');
  }

  Widget MakePublishingT() {
    return Text('출판사');
  }

  Widget MakeSubjectT() {
    return Text('과목명');
  }

  Widget MakeNameF() {
    return Expanded(
      child: TextFormField(
        controller: _controller,
        onChanged: (value) {
          setState(() => _BookTitle = value);
          //print('Input Text = $inputText');
        },
      ),
    );
  }

  Widget MakeAuthorF() {
    return Expanded(
      child: TextFormField(
        onChanged: (value) {
          setState(() => _Bookauthor = value);
          //print('Input Text = $inputText');
        },
      ),
    );
  }

  Widget MakePublishingF() {
    return Expanded(
      child: TextFormField(
        onChanged: (value) {
          setState(() => _Publisher = value);
          //print('Input Text = $inputText');
        },
      ),
    );
  }

  Widget MakeSubjectF() {
    return Expanded(
      child: TextFormField(
        onChanged: (value) {
          setState(() => _Subject = value);
          //print('Input Text = $inputText');
        },
      ),
    );
  }

  Widget TitleT() {
    return Text('제목',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget PriceT() {
    return Text('가격',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget DetailExplanationT() {
    return Text('자세한 설명',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget WantPlaceT() {
    return Text('거래 희망 장소',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget HashtagT() {
    return Text('해시태그',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget TitleF() {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          setState(() => _Postname = value);
        },
        decoration: InputDecoration(
          hintText: '제목을 입력해주세요',
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
      width: 400,
    );
  }

  Widget PriceF() {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          setState(() => _Price = value);
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: '판매가격을 입력해주세요',
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
      width: 400,
    );
  }

  Widget DetailExplanationF() {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          setState(() => _Detail = value);
        },
        maxLength: 300,
        decoration: InputDecoration(
          hintText: '* 최대 300자 입력 가능',
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
      width: 400,
    );
  }

  Widget WantPlaceF() {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          setState(() => _MeetingPlace = value);
        },
        decoration: InputDecoration(
          hintText: '거래 희망 장소를 입력해주세요',
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
      width: 400,
    );
  }

  void DivideTag() {
    List<String> _tags = ttag!.split(','); // ttag가 null이 아님을 보장하고 ','로 분할
    _Tag1 = _tags.isNotEmpty ? _tags[0] : null; // 첫 번째 요소를 가져오고, 리스트가 비어 있으면 null 할당
    _Tag2 = _tags.isNotEmpty ? _tags[1] : null;
    _Tag3 = _tags.isNotEmpty ? _tags[2] : null;
    _Tag4 = _tags.isNotEmpty ? _tags[3] : null;
    _Tag5 = _tags.isNotEmpty ? _tags[4] : null;
  }

  Widget HashtagF() {
    return Container(
      child: TextFormField(
        onChanged: (value) {
          setState(() => ttag = value);
        },
        decoration: InputDecoration(
          hintText: '태그를 입력해주세요 (최대 5개)',
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
      width: 400,
    );
  }

  Widget BasicInformation() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: null,
        border: Border.all(color: Colors.deepOrangeAccent, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              MakeNameT(),
              SizedBox(width: 10),
              MakeNameF(),
            ],
          ),
          Row(
            children: [
              MakeAuthorT(),
              SizedBox(width: 10),
              MakeAuthorF(),
            ],
          ),
          Row(
            children: [
              MakePublishingT(),
              SizedBox(width: 10),
              MakePublishingF(),
            ],
          ),
          Row(
            children: [
              MakeSubjectT(),
              SizedBox(width: 10),
              MakeSubjectF(),
            ],
          ),
        ],
      ),
    );
  }
  Widget Handwritten() {
    const List<Widget> uml = <Widget>[
      Text('있음'),
      Text('없음'),
    ];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('필기 여부',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  //isSelected[i] = i == index;
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

  Widget BookCondition() {
    const List<Widget> uml = <Widget>[
      Text('상'),
      Text('중'),
      Text('하'),
    ];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('책 상태',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(width: 50),
          ToggleButtons(
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelectedd.length; i++) {
                  if (i == index) {
                    isSelectedd[i] = !isSelectedd[i];
                  } else {
                    isSelectedd[i] = false;
                  }
                  //isSelected[i] = i == index;
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
            isSelected: isSelectedd,
            children: uml,
          ),
        ],
      ),
    );
  }

  Widget CameraButton() {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 5)
        ],
      ),
      child: IconButton(
        onPressed: () async {
          image = await picker.pickImage(source: ImageSource.camera);
          if (image != null) {
            setState(() {
              images.add(image);
            });
          }
        },
        icon: Icon(
          Icons.add_a_photo,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget AddPictureButton() {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 5)
        ],
      ),
      child: IconButton(
        onPressed: () async {
          multiImage = await picker.pickMultiImage();
          setState(() {
            images.addAll(multiImage);
          });
        },
        icon: Icon(
          Icons.add_photo_alternate_outlined,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget complete() {
    return ElevatedButton(
        onPressed: () {
          saveText();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFE8653),
            textStyle: const TextStyle(color: Colors.white),
            padding: EdgeInsets.only(left: 100, right: 100)),
        child: const Text('등록완료',style: TextStyle(color: Colors.white)));
  }
}
/*Widget ShowPicture() {
    return Container(
    height: 10,
    child: GridView.builder(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(
                    File(images[index]!.path),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 15,
                ),
                onPressed: () {
                  setState(() {
                    images.removeAt(index);
                  });
                },
              ),
            ),
          ],
        );
      },
    ));
  }*/
