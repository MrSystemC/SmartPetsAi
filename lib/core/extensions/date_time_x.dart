import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toDisplayDate() => DateFormat('dd.MM.yyyy HH:mm').format(this);
}
