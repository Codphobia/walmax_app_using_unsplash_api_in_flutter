class PhotoUrl {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  PhotoUrl(
      {required this.raw,
      required this.full,
      required this.regular,
      required this.small,
      required this.thumb});

  static PhotoUrl formMap(Map<String, dynamic> map) {
    return PhotoUrl(
        raw: map['urls']['raw'],
        full: map['urls']['full'],
        regular: map['urls']['regular'],
        small: map['urls']['small'],
        thumb: map['urls']['thumb']);
  }
}
