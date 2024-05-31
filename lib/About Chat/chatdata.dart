import 'package:chatview/chatview.dart';

class ChatMessage{
  final String id;
  final String profileImage;
  final String location;
  final sendDate;
  final String message;
  final String? imageUri;

  ChatMessage({
    required this.id,
    required this.profileImage,
    required this.location,
    required this.sendDate,
    required this.message,
    this.imageUri,
});
}

List<ChatMessage> chatMessageList=[
  ChatMessage(
    id:'백경이, ',
    profileImage:'',
    location: '대연동',
    sendDate: '1일전',
    message: '백경이는 내가 데리고 가고 싶다',
  ),
  ChatMessage(
    id:'뿌공이, ',
    profileImage:'',
    location: '대연동',
    sendDate: '3시간전',
    message: '뿌공이 날 수 있나요?',
  ),
];