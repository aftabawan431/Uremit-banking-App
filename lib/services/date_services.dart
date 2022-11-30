import 'package:intl/intl.dart';

class DateService {
  String format(DateTime date) {
    // 2025-05-21 10:15:30.5555555 +07:30
    String formattedDate =
        DateFormat('yyyy-MM-dd hh:mm:ss.SSSSSSSSS').format(date);

    var duration = date.timeZoneOffset;

    if (duration.isNegative)
      return (formattedDate +
          " -${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
    else
      return (formattedDate +
          " +${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
  }
}
