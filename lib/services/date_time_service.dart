import 'package:intl/intl.dart';

class DateTimeService {
  static String formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('MMMM d, yyyy').format(date);
  }

  static String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String getDateText(String date) {
    final DateFormat dateFormat = DateFormat('MMMM d, yyyy');
    final DateTime inputDate = dateFormat.parse(date);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final dateToCheck =
        DateTime(inputDate.year, inputDate.month, inputDate.day);

    if (dateToCheck == today) {
      return "Today";
    } else if (dateToCheck == yesterday) {
      return "Yesterday";
    } else {
      return date;
    }
  }
}
