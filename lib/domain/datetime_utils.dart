import 'package:intl/intl.dart';

class DateTimeUtils {
  static String parseDateTime(DateTime dateTime) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    var output = outputFormat.format(dateTime);
    return output;
  }

  static DateTime getWeekendDate(DateTime dateTime) {
    return dateTime.add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));

  }
}
