import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_01/successPage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddPicture extends StatefulWidget {
  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  final picker = ImagePicker();
  XFile? image;
  List<XFile?> multiImage = [];
  List<XFile?> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(MainPage());
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('판매'),
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
            AboutText(),
            BasicInformation(),
            BookCondition(),
            const SizedBox(
              height: 200,
              width: 200,
            ),
            TitleT(),
            Row(children: [TitleF()]),
            const SizedBox(height: 20),
            PriceT(),
            Row(children: [PriceF()]),
            const SizedBox(height: 20),
            DetailExplanationT(),
            Row(children: [DetailExplanationF()]),
            const SizedBox(height: 20),
            WantPlaceT(),
            Row(children: [WantPlaceF()]),
            const SizedBox(height: 20),
            HashtagT(),
            Row(children: [HashtagF()]),
            const SizedBox(height: 20),
            complete(),
          ],
        ),
      ),
      )
    );
  }

  Widget AboutText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('책에 대한 정보', style: TextStyle(fontSize: 25,
        fontWeight: FontWeight.bold,)),
    );
  }

  Widget MakeNameT() {
    return Text('책 이름');
  }

  Widget MakeAuthorT() {
    return Text('저자');
  }

  Widget MakePublishingT() {
    return Text('출판사');
  }

  Widget MakeSubjectT() {
    return Text('과목명');
  }

  Widget MakeNameF() {
    return Expanded(
      child: TextFormField(),
    );
  }

  Widget MakeAuthorF() {
    return Expanded(
      child: TextFormField(),
    );
  }

  Widget MakePublishingF() {
    return Expanded(
      child: TextFormField(),
    );
  }

  Widget MakeSubjectF() {
    return Expanded(
      child: TextFormField(),
    );
  }

  Widget TitleT(){
    return Text('제목',style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ));
  }

  Widget PriceT(){
    return Text('가격',style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ));
  }

  Widget DetailExplanationT(){
    return Text('자세한 설명',style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ));
  }

  Widget WantPlaceT(){
    return Text('거래 희망 장소',style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ));
  }

  Widget HashtagT(){
    return Text('해시태그',style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ));
  }

  Widget TitleF(){
    return Expanded(
      child: TextFormField(
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
    );
  }

  Widget PriceF(){
    return Expanded(
      child: TextFormField(
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
    );
  }

  Widget DetailExplanationF(){
    return Expanded(
      child: TextFormField(
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
    );
  }

  Widget WantPlaceF(){
    return Expanded(
      child: TextFormField(decoration: InputDecoration(
        hintText: '거래 희망 장소를 입력해주세요',
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),),
    );
  }

  Widget HashtagF(){
    return Expanded(
      child: TextFormField(
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
      ),),
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

  Widget BookCondition() {
    final isSelected = <bool>[false, false, false];
    const List<Widget> uml = <Widget>[
      Text('상'),
      Text('중'),
      Text('하'),
    ];
    bool vertical = false;
    final List<bool> _uml = <bool>[true, false, false];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('책 상태',style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.bold)),
          ToggleButtons(
            direction: vertical ? Axis.vertical : Axis.horizontal,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < _uml.length; i++) {
                  if (i == index) {
                    isSelected[i] = !isSelected[i];
                  } else {
                    isSelected[i] = false;
                  }
                  //_uml[i] = i == index;
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
            isSelected: _uml,
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

  Widget complete(){
    return ElevatedButton(onPressed: (){
      Get.to(MainPage());
    }, style: ElevatedButton.styleFrom(padding: EdgeInsets.only(left:100,right:100)), child: const Text('등록완료'));
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
}
