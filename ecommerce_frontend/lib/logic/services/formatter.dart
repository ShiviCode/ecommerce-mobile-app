import 'package:intl/intl.dart';

class Formatter {
  static String formatDate(DateTime date) {
    DateTime localDateTime = date.toLocal();
    final dateFormat = DateFormat("dd MMM y, hh:mm a");
    return dateFormat.format(localDateTime);
  }
}

//utc time zone