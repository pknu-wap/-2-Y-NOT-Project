import 'package:flutter/gestures.dart';
class searchresult{
  final String subject;
  final String auther;
  final String publishing;

  searchresult({
    required this.subject,
    required this.auther,
    required this.publishing,
});
}

final List<searchresult> datas =[
  searchresult(
      subject: "공학경제개론",
      auther: "박찬성",
      publishing: "청람"
  ),
  searchresult(
      subject: "대학물리학",
      auther: "Raymond A.Serway",
      publishing: "북스힐"
  ),
  searchresult(
      subject: "해도의 세계사",
      auther: "미아자키 마사카츠",
      publishing: "어문학사"
  ),
  searchresult(
      subject: "기초공학수학",
      auther: "김동식",
      publishing: "생능"
  ),
  searchresult(
      subject: "선형대수학과 응용",
      auther: "이재진",
      publishing: "경문사"
  ),
  searchresult(
      subject: "스튜어트 미분적분학",
      auther: "James Stewart",
      publishing: "북스힐"
  ),
  searchresult(
    subject: '',
    auther: '',
    publishing: ''
  ),
];