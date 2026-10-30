import 'dart:math';
import 'package:intl/intl.dart';

class Formatters {
  static final NumberFormat _currencyFormatUSD = NumberFormat.currency(
    symbol: '\$',
    decimalDigits: 0,
  );

  static final NumberFormat _currencyFormatINR = NumberFormat.currency(
    symbol: '₹',
    decimalDigits: 0,
    locale: 'en_IN',
  );

  static final NumberFormat _numberFormat = NumberFormat('#,##0');

  static String formatCurrency(num amount, {bool inINR = false}) {
    if (inINR) {
      return _currencyFormatINR.format(amount);
    }
    return _currencyFormatUSD.format(amount);
  }

  static String formatSqFt(int sqFt) {
    return '${_numberFormat.format(sqFt)} sq.ft.';
  }

  static String formatPercentage(double percent) {
    return '${(percent * 100).toStringAsFixed(1)}%';
  }

  static String generateDeedToken() {
    final random = Random();
    final part1 = random.nextInt(9000) + 1000;
    final chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ';
    final part2 = List.generate(3, (_) => chars[random.nextInt(chars.length)]).join();
    return 'PTF-$part1-$part2';
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('MMMM d, yyyy • h:mm a').format(dateTime);
  }

  static String formatDateShort(DateTime dateTime) {
    return DateFormat('MMM d, yyyy').format(dateTime);
  }
}
