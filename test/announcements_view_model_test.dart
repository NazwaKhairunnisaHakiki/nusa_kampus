import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/data/repositories/announcement_repository.dart';
import 'package:nusa_kampus/data/services/campus_service.dart';
import 'package:nusa_kampus/domain/models/announcement.dart';
import 'package:nusa_kampus/ui/announcements/announcements_view_model.dart';

class FakeAnnouncementRepository extends AnnouncementRepository {
  FakeAnnouncementRepository() : super(CampusService());

  @override
  Future<List<Announcement>> getAnnouncements() async {
    return [
      Announcement(
        id: 'A001',
        title: 'Campus Seminar',
        content: 'Join our campus technology seminar.',
        publishedAt: DateTime(2026, 11, 14),
      ),
    ];
  }
}

void main() {
  group('AnnouncementsViewModel Test', () {
    test('load announcements successfully', () async {
      final repository = FakeAnnouncementRepository();
      final viewModel = AnnouncementsViewModel(repository);

      await viewModel.load();

      expect(viewModel.isLoading, false);
      expect(viewModel.error, isNull);
      expect(viewModel.announcements.length, 1);
      expect(viewModel.announcements.first.title, 'Campus Seminar');

      viewModel.dispose();
    });
  });
}
