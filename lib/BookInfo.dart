class PlusCondition {
  final String? price;
  final String? picture;
  final String? time;
  final String? subject;
  final String? postname;
  final String? detail;
  final String? quality;
  final bool? takenote;
  List<String>? tags;

  PlusCondition({
    this.price,
    this.picture,
    this.time,
    this.subject,
    this.postname,
    this.quality,
    this.detail,
    this.takenote,
    this.tags,
  });
}

class BookInfo {
  final String title;
  final String author;
  final String publishing;
  final PlusCondition? condition;

  BookInfo({
    required this.title,
    required this.author,
    required this.publishing,
    this.condition,
  });
}