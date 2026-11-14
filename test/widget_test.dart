import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/app.dart';

void main() {
  testWidgets('NusaKampus app displays navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NusaKampusApp());

    // Beri waktu untuk menyelesaikan Future.delayed
    // dari CampusService dan proses pemuatan halaman.
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    await tester.pump();

    expect(find.text('NusaKampus'), findsOneWidget);
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Jadwal'), findsOneWidget);
    expect(find.text('Tugas'), findsOneWidget);
    expect(find.text('Pengumuman'), findsOneWidget);
  });
}
