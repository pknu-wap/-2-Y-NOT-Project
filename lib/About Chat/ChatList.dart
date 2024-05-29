import 'package:flutter/material.dart';
import 'package:flutter_01/About Chat/chatdata.dart';
import 'package:flutter_01/About Chat/chat.dart';

class ImageContainer extends StatelessWidget {
  final double borderRadius;
  final String imageurl;
  final double width;
  final double height;

  const ImageContainer({
    Key? key,
    required this.borderRadius,
    required this.imageurl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageurl,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅'),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      body: ListView(
        children: List.generate(
          chatMessageList.length,
              (index) => ChatContainer(chatMessage: chatMessageList[index]),
        ),
      ),
    );
  }
}

class ChatContainer extends StatelessWidget {
  const ChatContainer({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);
  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen())
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              /*ImageContainer(
                width: 50,
                height: 50,
                borderRadius: 25,
                imageurl: chatMessage.profileImage,
              ),*/
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: chatMessage.id,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' ${chatMessage.location}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: ' • ${chatMessage.sendDate}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ]),
                    ),
                    const Spacer(),
                    Text(
                      chatMessage.message,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Visibility(
                visible: chatMessage.imageUri != null,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ImageContainer(
                    width: 50,
                    height: 50,
                    borderRadius: 8,
                    imageurl: chatMessage.imageUri ?? '',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}