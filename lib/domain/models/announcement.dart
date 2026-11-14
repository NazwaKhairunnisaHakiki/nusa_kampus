class Announcement {
  final String id;
  final String title;
  final String content;
  final DateTime publishedAt;

  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.publishedAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
    );
  }
}
