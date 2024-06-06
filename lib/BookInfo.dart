class PlusCondition {
  final String? price;
  final String? picture;
  List<String>? tags;

  PlusCondition({
    this.price,
    this.picture,
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