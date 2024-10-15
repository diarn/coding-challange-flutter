import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  String toStringDay() {
    return DateFormat("MMM dd,yyyy").format(this);
  }

  String toStringDayWithTime() {
    return DateFormat("yy/MM/dd, HH:mm:ss").format(this);
  }
}
