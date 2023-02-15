import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constant_lib.dart';

class DateTimes {

  static String get nowAsString => reverseDate(
      DateTime.now().toIso8601String(),
      withTime: true,
      invert: true
  );

  static String get nowDiffFourAsString => reverseDate(
      DateTime.now().add(const Duration(hours: 4)).toIso8601String(),
      withTime: true,
      invert: true
  );

  static String get dateNowAsString => reverseDate(
      DateTime.now().toIso8601String(),
      invert: true
  );

  static String dateSubsAsString(int diff) {
    int diff0 = diff < 0 ? 0 : diff;
    DateTime date = DateTime.now().subtract(Duration(days: diff0));

    return reverseDate(
      date.toIso8601String(),
      invert: true
    );
  }

  static String dateAddAsString(int diff) {
    int diff0 = diff < 0 ? 0 : diff;
    DateTime date = DateTime.now().add(Duration(days: diff0));

    return reverseDate(
      date.toIso8601String(),
      invert: true
    );
  }

  static String formatDate(String value, {bool showDayName = true, bool showTime = false}) {
    return DateFormat(
        "${showDayName ? 'EEEE, ' : ''}d MMMM yyyy${showTime ? ' HH:mm' : ''}","id_ID"
    ).format(DateTime.parse(value.contains(':') ? value : '$value 00:00:00'));
  }

  static String formatTime(dynamic value, {bool showHours = false, bool showSec = true}) {
    DateTime dateTime;
    if (value is DateTime) {
      dateTime = value;
    } else {
      dateTime = DateTime.parse(value);
    }

    String format = "HH:mm:ss";
    if (showHours) {
      if (showSec) {
        format = "HH:mm:ss";
      } else {
        format = "HH:mm";
      }
    } else {
      if (showSec) {
        format = "mm:ss";
      } else {
        format = "mm";
      }
    }

    return DateFormat(format,"id_ID").format(dateTime);
  }

  static String zeroLeadTime(int time) {
    return '${time>9?time:'0$time'}';
  }

  static String get hourName {
    TimeOfDay dayName = TimeOfDay.fromDateTime(DateTime.now());
    if (dayName.hour > 0 && dayName.hour <= 11) {
      return 'pagi';
    } else if (dayName.hour > 11 && dayName.hour <= 14) {
      return 'siang';
    } else if (dayName.hour > 14 && dayName.hour <= 18) {
      return 'sore';
    } else if (dayName.hour > 18 && dayName.hour <= 24) {
      return 'malam';
    } else {
      return '';
    }
  }

  static String getTime(int hour, int minute, {bool withSeconds = false}) {
    return '${zeroLeadTime(hour)}:${zeroLeadTime(minute)}${withSeconds?':00':''}';
  }

  static String reverseDate(String value, {bool withTime = false, bool invert = false}) {
    if (withTime) {
      return DateFormat(invert ? "y-MM-dd HH:mm:ss" : "d-M-y HH:mm:ss", ConstLib.localeID).format(DateTime.parse(value));
    } else {
      return DateFormat(invert ? "y-MM-dd" : "d-M-y", ConstLib.localeID).format(DateTime.parse(value));
    }
  }

  /*
  * reference: https://medium.com/@mger/flutter-date-format-just-now-yesterday-weekday-cb2ed3d2a126
  * */
  static String verboseTime(String startDate, {bool withYear = false}) {
    var start = DateTime.parse(startDate);

    DateTime now = DateTime.now();
    DateTime justNow = DateTime.now().subtract(const Duration(minutes: 1));
    DateTime localDateTime = start.toLocal();
    if (!localDateTime.difference(justNow).isNegative) {
      return 'Just now';
    }

    String roughTimeString = DateFormat('jm').format(start);
    if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return 'Today, $roughTimeString';
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (localDateTime.day == yesterday.day && localDateTime.month == yesterday.month && localDateTime.year == yesterday.year) {
      return 'Yesterday, $roughTimeString';
    }

    if (now.difference(localDateTime).inDays < 4) {
      String weekday = DateFormat('EEEE').format(localDateTime);
      return '$weekday, $roughTimeString';
    }

    String format = 'd MMM';
    if (withYear) format = 'd MMM y';
    return '${DateFormat(format, 'id_ID').format(start)}, $roughTimeString';
  }
}