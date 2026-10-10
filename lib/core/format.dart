import 'package:intl/intl.dart';

/// Formatting for dates, money and counts in the device locale.
abstract final class Format {
  /// "Today, 18:30", "Tomorrow, 18:30", "Sat 13 Oct, 18:30", or with the
  /// year when it isn't this year.
  static String dateTime(DateTime value, {DateTime? now}) {
    final local = value.toLocal();
    final today = _day(now ?? DateTime.now());
    final day = _day(local);
    final time = DateFormat.Hm().format(local);
    final difference = day.difference(today).inDays;
    if (difference == 0) return 'Today, $time';
    if (difference == 1) return 'Tomorrow, $time';
    if (difference == -1) return 'Yesterday, $time';
    final date = local.year == today.year
        ? DateFormat('EEE d MMM').format(local)
        : DateFormat('d MMM y').format(local);
    return '$date, $time';
  }

  /// "Sat 13 Oct" (or "13 Oct 2027" in another year).
  static String date(DateTime value, {DateTime? now}) {
    final local = value.toLocal();
    final year = (now ?? DateTime.now()).year;
    return local.year == year
        ? DateFormat('EEE d MMM').format(local)
        : DateFormat('d MMM y').format(local);
  }

  /// Money from minor units with the currency's own decimals, dropping a
  /// zero fraction: "Ksh 100", "₹49.50", "\$5".
  static String money(int minorUnits, String currency) {
    final digits =
        NumberFormat.simpleCurrency(name: currency).decimalDigits ?? 2;
    final major = minorUnits / _pow10(digits);
    final whole = major == major.roundToDouble();
    final format = NumberFormat.simpleCurrency(
      name: currency,
      decimalDigits: whole ? 0 : digits,
    );
    final out = format.format(major);
    // A lettered symbol ("Ksh", "KES") reads as a word, so it needs a space;
    // "₹" and "\$" attach to the number.
    final symbol = format.currencySymbol;
    final lettered = RegExp(r'\p{L}$', unicode: true).hasMatch(symbol);
    return lettered && out.startsWith(symbol) && !out.startsWith('$symbol ')
        ? out.replaceFirst(symbol, '$symbol ')
        : out;
  }

  /// A whole number with grouping: "1,542".
  static String number(num value) =>
      NumberFormat.decimalPattern().format(value);

  /// A deadline in words: "Closes in 45 min", "Closes in 5 hours",
  /// "Closes in 2 days", or "Closed".
  static String closesIn(DateTime deadline, {DateTime? now}) {
    final left = deadline.difference(now ?? DateTime.now());
    if (left.isNegative) return 'Closed';
    if (left.inMinutes < 60) {
      return 'Closes in ${left.inMinutes.clamp(1, 59)} min';
    }
    if (left.inHours < 24) {
      final h = left.inHours;
      return 'Closes in $h hour${h == 1 ? '' : 's'}';
    }
    final d = left.inDays;
    return 'Closes in $d day${d == 1 ? '' : 's'}';
  }

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  static int _pow10(int n) => n <= 0 ? 1 : 10 * _pow10(n - 1);
}
