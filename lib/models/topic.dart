class Topic {
  String title;
  String photos;

  Topic({required this.title, required this.photos});

  static Topic formMap(Map<String, dynamic> map) {
    return Topic(title: map['title'], photos: map['links']['photos']);
  }
}
