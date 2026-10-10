import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/core/format.dart';

void main() {
  group('money', () {
    test('drops a zero fraction and spaces a lettered symbol', () {
      expect(Format.money(10000, 'KES'), 'Ksh 100');
      expect(Format.money(800000, 'KES'), 'Ksh 8,000');
    });

    test('keeps real fractions and attaches symbols', () {
      expect(Format.money(4950, 'INR'), '₹49.50');
      expect(Format.money(500, 'USD'), r'$5');
      expect(Format.money(1250, 'USD'), r'$12.50');
    });
  });

  group('dateTime', () {
    final now = DateTime(2026, 10, 9, 12);

    test('names today, tomorrow and yesterday', () {
      expect(
        Format.dateTime(DateTime(2026, 10, 9, 18, 30), now: now),
        'Today, 18:30',
      );
      expect(
        Format.dateTime(DateTime(2026, 10, 10, 9, 5), now: now),
        'Tomorrow, 09:05',
      );
      expect(
        Format.dateTime(DateTime(2026, 10, 8, 20), now: now),
        'Yesterday, 20:00',
      );
    });

    test('uses a short date this year and adds the year otherwise', () {
      expect(
        Format.dateTime(DateTime(2026, 10, 13, 18, 30), now: now),
        'Tue 13 Oct, 18:30',
      );
      expect(
        Format.dateTime(DateTime(2027, 1, 2, 8), now: now),
        '2 Jan 2027, 08:00',
      );
    });
  });
}
