// ignore_for_file: depend_on_referenced_packages


import 'package:intl/intl.dart';

class FormatHelper {
  FormatHelper._();

  static String formatDate(String pattern, DateTime? date) {
    if (date == null) return "";
    return DateFormat(pattern).format(date.toLocal());
  }

  static String formatDistance(double? distance) {
    if (distance == null) return "";
    return "${distance.toStringAsFixed(2)} km";
  }

  static String formatCreatedDate(DateTime? date) {
    if (date == null) return "";
    return formatDate("dd/MM/yyyy, kk:mm", date);
  }

  static String formatId(int? id) {
    if (id == null) return "";
    return "#$id";
  }

}
