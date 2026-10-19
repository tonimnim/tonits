import 'package:intl/intl.dart';

import 'l10n.dart';

/// Formatting for dates, money and counts in the device locale.
abstract final class Format {
  /// "Today, 18:30", "Tomorrow, 18:30", "Sat 13 Oct, 18:30", or with the
  /// year when it isn't this year.
  static String dateTime(DateTime value, AppLocalizations l, {DateTime? now}) {
    final local = value.toLocal();
    final today = _day(now ?? DateTime.now());
    final day = _day(local);
    final time = DateFormat.Hm().format(local);
    final difference = day.difference(today).inDays;
    if (difference == 0) return l.formatToday(time);
    if (difference == 1) return l.formatTomorrow(time);
    if (difference == -1) return l.formatYesterday(time);
    final date = local.year == today.year
        ? DateFormat('EEE d MMM').format(local)
        : DateFormat('d MMM y').format(local);
    return l.formatDateTime(date, time);
  }

  /// "Sat 13 Oct" (or "13 Oct 2027" in another year).
  static String date(DateTime value, {DateTime? now}) {
    final local = value.toLocal();
    final year = (now ?? DateTime.now()).year;
    return local.year == year
        ? DateFormat('EEE d MMM').format(local)
        : DateFormat('d MMM y').format(local);
  }

  /// "March 2026".
  static String monthYear(DateTime value) =>
      DateFormat('MMMM y').format(value.toLocal());

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
  static String closesIn(
    DateTime deadline,
    AppLocalizations l, {
    DateTime? now,
  }) {
    final left = deadline.difference(now ?? DateTime.now());
    if (left.isNegative) return l.closed;
    if (left.inMinutes < 60) {
      return l.closesInMinutes(left.inMinutes.clamp(1, 59));
    }
    if (left.inHours < 24) return l.closesInHours(left.inHours);
    return l.closesInDays(left.inDays);
  }

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  static int _pow10(int n) => n <= 0 ? 1 : 10 * _pow10(n - 1);
}
