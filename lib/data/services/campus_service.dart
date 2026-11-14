import '../../domain/models/course.dart';
import '../../domain/models/task.dart';
import '../../domain/models/announcement.dart';

class CampusService {
  Future<List<Course>> fetchCourses() async {
    await Future.delayed(const Duration(seconds: 1));

    return const [
      Course(
        id: 'C001',
        name: 'Mobile Programming',
        lecturer: 'Mr. Andi Pratama',
        day: 'Monday',
        startTime: '08:00',
        endTime: '10:00',
        room: 'Lab 1',
      ),
      Course(
        id: 'C002',
        name: 'Database Systems',
        lecturer: 'Mrs. Siti Rahma',
        day: 'Monday',
        startTime: '10:00',
        endTime: '12:00',
        room: 'Room 202',
      ),
      Course(
        id: 'C003',
        name: 'Software Engineering',
        lecturer: 'Mr. Budi Santoso',
        day: 'Tuesday',
        startTime: '09:00',
        endTime: '11:00',
        room: 'Room 301',
      ),
      Course(
        id: 'C004',
        name: 'Web Programming',
        lecturer: 'Mrs. Dewi Lestari',
        day: 'Wednesday',
        startTime: '08:00',
        endTime: '10:00',
        room: 'Lab 2',
      ),
      Course(
        id: 'C005',
        name: 'Computer Networks',
        lecturer: 'Mr. Rudi Hartono',
        day: 'Thursday',
        startTime: '13:00',
        endTime: '15:00',
        room: 'Room 105',
      ),
      Course(
        id: 'C006',
        name: 'Artificial Intelligence',
        lecturer: 'Mrs. Maya Putri',
        day: 'Friday',
        startTime: '09:00',
        endTime: '11:00',
        room: 'Lab 3',
      ),
    ];
  }

  Future<List<Task>> fetchTasks() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Task(
        id: 'T001',
        title: 'Complete Flutter Assignment',
        description: 'Build a campus application using Flutter.',
        dueDate: DateTime.now().add(const Duration(days: 2)),
      ),
      Task(
        id: 'T002',
        title: 'Database Design Report',
        description: 'Prepare the database design report.',
        dueDate: DateTime.now().add(const Duration(days: 3)),
      ),
      Task(
        id: 'T003',
        title: 'Software Engineering Quiz',
        description: 'Study software development life cycle.',
        dueDate: DateTime.now().add(const Duration(days: 5)),
      ),
    ];
  }

  Future<List<Announcement>> fetchAnnouncements() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Announcement(
        id: 'A001',
        title: 'Campus Seminar',
        content:
            'Join our technology seminar this Friday at the main auditorium.',
        publishedAt: DateTime.now(),
      ),
      Announcement(
        id: 'A002',
        title: 'Library Schedule Update',
        content:
            'The campus library will be open from 8 AM to 5 PM on weekdays.',
        publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Announcement(
        id: 'A003',
        title: 'Student Registration',
        content: 'Course registration for the next semester is now available.',
        publishedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }
}
