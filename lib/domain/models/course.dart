class Course {
  final String id;
  final String name;
  final String lecturer;
  final String day;
  final String startTime;
  final String endTime;
  final String room;

  const Course({
    required this.id,
    required this.name,
    required this.lecturer,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.room,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as String,
      name: json['name'] as String,
      lecturer: json['lecturer'] as String,
      day: json['day'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      room: json['room'] as String,
    );
  }
}
