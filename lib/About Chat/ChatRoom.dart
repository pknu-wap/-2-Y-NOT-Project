import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatList extends StatefulWidget{
  @override
  _ChatListState createState() => _ChatListState();

}

class _ChatListState extends State<ChatList>{
  final _controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override

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

  void saveRoom(){
    FirebaseFirestore.instance.collection('chatroom').add({
      //'Image':,//프로필 사진
      'Sender': loggedInUser!.email,//채팅보내는 사람
      //'BookId':,//책document코드
      'Timestamp': Timestamp.now(),//최신순 정렬을 위해
    });
    _controller.clear();
  }

  Widget build(BuildContext context){
    return Scaffold(

    );
  }
}