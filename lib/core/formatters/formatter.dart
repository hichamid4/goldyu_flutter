import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatCurrency(double? amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('+212') && phoneNumber.length == 13) {
      return '+212 ${phoneNumber.substring(4, 6)}-${phoneNumber.substring(6, 9)}-${phoneNumber.substring(9)}';
    } else if (phoneNumber.startsWith('0') && phoneNumber.length == 10) {
      return '0${phoneNumber.substring(1, 3)}-${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    } else {
      return phoneNumber;
    }
  }
}
