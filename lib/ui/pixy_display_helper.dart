import 'dart:math';

import 'package:intl/intl.dart';
import 'package:pixy_clock/ui/config.dart';
import 'package:pixy_clock/ui/pixy_number.dart';

class PixyDisplayHelper {
  static double normalize(double v) => ((v + 1) / 2);

  static double smoothen(double v, double smooth) {
    double i = smooth * v;
    var res = (1 - smooth) + i;
    return res;
  }

  static PixyNumberUpdate getHourUpdate(DateTime date, bool first) {
    if (date == null) {
      return null;
    }

    DateTime prevDate = DateTime(date.year, date.month, date.day, date.hour - 1,
        date.minute, date.second);
    String prevHour = DateFormat(Config.USE_12_HOURS_FORMAT ? "h" : "H")
        .format(prevDate)
        .padLeft(2, '0');
    String currentHour = DateFormat(Config.USE_12_HOURS_FORMAT ? "h" : "H")
        .format(date)
        .padLeft(2, '0');
    return PixyNumberUpdate(currentHour.substring(first ? 0 : 1, first ? 1 : 2),
        prevHour.substring(first ? 0 : 1, first ? 1 : 2));
  }

  static PixyNumberUpdate getMinuteUpdate(DateTime date, bool first) {
    if (date == null) {
      return null;
    }

    DateTime prevDate = DateTime(date.year, date.month, date.day, date.hour,
        date.minute - 1, date.second);
    String prevMinute = DateFormat("m").format(prevDate).padLeft(2, '0');
    String currentMinute = DateFormat("m").format(date).padLeft(2, '0');
    return PixyNumberUpdate(
        currentMinute.substring(first ? 0 : 1, first ? 1 : 2),
        prevMinute.substring(first ? 0 : 1, first ? 1 : 2));
  }

  static final numPixyMap = {
    ":": [
      Point(2, 0),
      Point(2, 1),
      Point(2, 12),
      Point(2, 13),
      Point(3, 0),
      Point(3, 1),
      Point(3, 12),
      Point(3, 13),
    ],
    "1": [
      Point(2, 0),
      Point(2, 1),
      Point(2, 2),
      Point(2, 3),
      Point(2, 4),
      Point(2, 5),
      Point(2, 6),
      Point(2, 7),
      Point(2, 8),
      Point(2, 9),
      Point(2, 10),
      Point(2, 11),
      Point(2, 12),
      Point(2, 13),
      Point(3, 0),
      Point(3, 1),
      Point(3, 2),
      Point(3, 3),
      Point(3, 4),
      Point(3, 5),
      Point(3, 6),
      Point(3, 7),
      Point(3, 8),
      Point(3, 9),
      Point(3, 10),
      Point(3, 11),
      Point(3, 12),
      Point(3, 13),
    ],
    "2": [
      //TOP
      Point(0, 0),
      Point(0, 1),
      Point(1, 0),
      Point(1, 1),
      Point(2, 0),
      Point(2, 1),
      Point(3, 0),
      Point(3, 1),
      Point(4, 0),
      Point(4, 1),
      Point(5, 0),
      Point(5, 1),

      //BOTTOM
      Point(0, 12),
      Point(0, 13),
      Point(1, 12),
      Point(1, 13),
      Point(2, 12),
      Point(2, 13),
      Point(3, 12),
      Point(3, 13),
      Point(4, 12),
      Point(4, 13),
      Point(5, 12),
      Point(5, 13),

      //UP DOWN
      Point(4, 2),
      Point(5, 2),
      Point(4, 3),
      Point(5, 3),
      Point(4, 4),
      Point(5, 4),
      Point(4, 5),
      Point(5, 5),

      //BOTTOM UP
      Point(0, 11),
      Point(1, 11),
      Point(0, 10),
      Point(1, 10),
      Point(0, 9),
      Point(1, 9),
      Point(0, 8),
      Point(1, 8),

      //MIDDLE
      Point(0, 6),
      Point(0, 7),
      Point(1, 6),
      Point(1, 7),
      Point(2, 6),
      Point(2, 7),
      Point(3, 6),
      Point(3, 7),
      Point(4, 6),
      Point(4, 7),
      Point(5, 6),
      Point(5, 7),
    ],
    "3": [
      //TOP
      Point(0, 0),
      Point(0, 1),
      Point(1, 0),
      Point(1, 1),
      Point(2, 0),
      Point(2, 1),
      Point(3, 0),
      Point(3, 1),
      Point(4, 0),
      Point(4, 1),
      Point(5, 0),
      Point(5, 1),

      //BOTTOM
      Point(0, 12),
      Point(0, 13),
      Point(1, 12),
      Point(1, 13),
      Point(2, 12),
      Point(2, 13),
      Point(3, 12),
      Point(3, 13),
      Point(4, 12),
      Point(4, 13),
      Point(5, 12),
      Point(5, 13),

      //UP DOWN
      Point(4, 2),
      Point(5, 2),
      Point(4, 3),
      Point(5, 3),
      Point(4, 4),
      Point(5, 4),
      Point(4, 5),
      Point(5, 5),

      //BOTTOM UP
      Point(4, 11),
      Point(5, 11),
      Point(4, 10),
      Point(5, 10),
      Point(4, 9),
      Point(5, 9),
      Point(4, 8),
      Point(5, 8),

      //MIDDLE
      Point(0, 6),
      Point(0, 7),
      Point(1, 6),
      Point(1, 7),
      Point(2, 6),
      Point(2, 7),
      Point(3, 6),
      Point(3, 7),
      Point(4, 6),
      Point(4, 7),
      Point(5, 6),
      Point(5, 7),
    ],
    "4": [
      //RIGHT
      Point(4, 0),
      Point(4, 1),
      Point(5, 0),
      Point(5, 1),
      Point(4, 2),
      Point(5, 2),
      Point(4, 3),
      Point(5, 3),
      Point(4, 4),
      Point(5, 4),
      Point(4, 5),
      Point(5, 5),
      Point(4, 11),
      Point(5, 11),
      Point(4, 10),
      Point(5, 10),
      Point(4, 9),
      Point(5, 9),
      Point(4, 8),
      Point(5, 8),
      Point(4, 12),
      Point(4, 13),
      Point(5, 12),
      Point(5, 13),
      Point(4, 6),
      Point(4, 7),
      Point(5, 6),
      Point(5, 7),

      //MIDDLE
      Point(0, 6),
      Point(0, 7),
      Point(1, 6),
      Point(1, 7),
      Point(2, 6),
      Point(2, 7),
      Point(3, 6),
      Point(3, 7),

      //LEFT UP
      Point(0, 0),
      Point(0, 1),
      Point(1, 0),
      Point(1, 1),
      Point(0, 2),
      Point(1, 2),
      Point(0, 3),
      Point(1, 3),
      Point(0, 4),
      Point(1, 4),
      Point(0, 5),
      Point(1, 5),
    ],
    "5": [
      //TOP
      Point(0, 0),
      Point(0, 1),
      Point(1, 0),
      Point(1, 1),
      Point(2, 0),
      Point(2, 1),
      Point(3, 0),
      Point(3, 1),
      Point(4, 0),
      Point(4, 1),
      Point(5, 0),
      Point(5, 1),

      //BOTTOM
      Point(0, 12),
      Point(0, 13),
      Point(1, 12),
      Point(1, 13),
      Point(2, 12),
      Point(2, 13),
      Point(3, 12),
      Point(3, 13),
      Point(4, 12),
      Point(4, 13),
      Point(5, 12),
      Point(5, 13),

      //DOWN UP
      Point(4, 8),
      Point(5, 8),
      Point(4, 9),
      Point(5, 9),
      Point(4, 10),
      Point(5, 10),
      Point(4, 11),
      Point(5, 11),

      //UP DOWN
      Point(0, 2),
      Point(1, 2),
      Point(0, 3),
      Point(1, 3),
      Point(0, 4),
      Point(1, 4),
      Point(0, 5),
      Point(1, 5),

      //MIDDLE
      Point(0, 6),
      Point(0, 7),
      Point(1, 6),
      Point(1, 7),
      Point(2, 6),
      Point(2, 7),
      Point(3, 6),
      Point(3, 7),
      Point(4, 6),
      Point(4, 7),
      Point(5, 6),
      Point(5, 7),
    ],
    "6": [
      //TOP
      Point(0, 0),
      Point(0, 1),
      Point(1, 0),
      Point(1, 1),
      Point(2, 0),
      Point(2, 1),
      Point(3, 0),
      Point(3, 1),
      Point(4, 0),
      Point(4, 1),
      Point(5, 0),
      Point(5, 1),

      //BOTTOM
      Point(0, 12),
      Point(0, 13),
      Point(1, 12),
      Point(1, 13),
      Point(2, 12),
      Point(2, 13),
      Point(3, 12),
      Point(3, 13),
      Point(4, 12),
      Point(4, 13),
      Point(5, 12),
      Point(5, 13),

      //DOWN UP RIGHT
      Point(4, 8),
      Point(5, 8),
      Point(4, 9),
      Point(5, 9),
      Point(4, 10),
      Point(5, 10),
      Point(4, 11),
      Point(5, 11),

      //DOWN UP LEFT
      Point(0, 8),
      Point(1, 8),
      Point(0, 9),
      Point(1, 9),
      Point(0, 10),
      Point(1, 10),
      Point(0, 11),
      Point(1, 11),

      //UP DOWN
      Point(0, 2),
      Point(1, 2),
      Point(0, 3),
      Point(1, 3),
      Point(0, 4),
      Point(1, 4),
      Point(0, 5),
      Point(1, 5),

      //MIDDLE
      Point(0, 6),
      Point(0, 7),
      Point(1, 6),
      Point(1, 7),
      Point(2, 6),
      Point(2, 7),
      Point(3, 6),
      Point(3, 7),
      Point(4, 6),
      Point(4, 7),
      Point(5, 6),
      Point(5, 7),
    ],
    "7": [
      //TOP
      Point(0, 0),
      Point(0, 1),
      Point(1, 0),
      Point(1, 1),
      Point(2, 0),
      Point(2, 1),
      Point(3, 0),
      Point(3, 1),
      Point(4, 0),
      Point(4, 1),
      Point(5, 0),
      Point(5, 1),

      //BOTTOM
      Point(4, 12),
      Point(4, 13),
      Point(5, 12),
      Point(5, 13),

      //DOWN UP RIGHT
      Point(4, 8),
      Point(5, 8),
      Point(4, 9),
      Point(5, 9),
      Point(4, 10),
      Point(5, 10),
      Point(4, 11),
      Point(5, 11),

      //UP DOWN RIGHT
      Point(4, 2),
      Point(5, 2),
      Point(4, 3),
      Point(5, 3),
      Point(4, 4),
      Point(5, 4),
      Point(4, 5),
      Point(5, 5),

      //MIDDLE
      Point(4, 6),
      Point(4, 7),
      Point(5, 6),
      Point(5, 7),
    ],
    "8": [
      //TOP
      Point(0, 0),
      Point(0, 1),
      Point(1, 0),
      Point(1, 1),
      Point(2, 0),
      Point(2, 1),
      Point(3, 0),
      Point(3, 1),
      Point(4, 0),
      Point(4, 1),
      Point(5, 0),
      Point(5, 1),

      //BOTTOM
      Point(0, 12),
      Point(0, 13),
      Point(1, 12),
      Point(1, 13),
      Point(2, 12),
      Point(2, 13),
      Point(3, 12),
      Point(3, 13),
      Point(4, 12),
      Point(4, 13),
      Point(5, 12),
      Point(5, 13),

      //DOWN UP RIGHT
      Point(4, 8),
      Point(5, 8),
      Point(4, 9),
      Point(5, 9),
      Point(4, 10),
      Point(5, 10),
      Point(4, 11),
      Point(5, 11),

      //DOWN UP LEFT
      Point(0, 8),
      Point(1, 8),
      Point(0, 9),
      Point(1, 9),
      Point(0, 10),
      Point(1, 10),
      Point(0, 11),
      Point(1, 11),

      //UP DOWN LEFT
      Point(0, 2),
      Point(1, 2),
      Point(0, 3),
      Point(1, 3),
      Point(0, 4),
      Point(1, 4),
      Point(0, 5),
      Point(1, 5),

      //UP DOWN RIGHT
      Point(4, 2),
      Point(5, 2),
      Point(4, 3),
      Point(5, 3),
      Point(4, 4),
      Point(5, 4),
      Point(4, 5),
      Point(5, 5),

      //MIDDLE
      Point(0, 6),
      Point(0, 7),
      Point(1, 6),
      Point(1, 7),
      Point(2, 6),
      Point(2, 7),
      Point(3, 6),
      Point(3, 7),
      Point(4, 6),
      Point(4, 7),
      Point(5, 6),
      Point(5, 7),
    ],
    "9": [
      //TOP
      Point(0, 0),
      Point(0, 1),
      Point(1, 0),
      Point(1, 1),
      Point(2, 0),
      Point(2, 1),
      Point(3, 0),
      Point(3, 1),
      Point(4, 0),
      Point(4, 1),
      Point(5, 0),
      Point(5, 1),

      //BOTTOM
      Point(0, 12),
      Point(0, 13),
      Point(1, 12),
      Point(1, 13),
      Point(2, 12),
      Point(2, 13),
      Point(3, 12),
      Point(3, 13),
      Point(4, 12),
      Point(4, 13),
      Point(5, 12),
      Point(5, 13),

      //DOWN UP RIGHT
      Point(4, 8),
      Point(5, 8),
      Point(4, 9),
      Point(5, 9),
      Point(4, 10),
      Point(5, 10),
      Point(4, 11),
      Point(5, 11),

      //UP DOWN LEFT
      Point(0, 2),
      Point(1, 2),
      Point(0, 3),
      Point(1, 3),
      Point(0, 4),
      Point(1, 4),
      Point(0, 5),
      Point(1, 5),

      //UP DOWN RIGHT
      Point(4, 2),
      Point(5, 2),
      Point(4, 3),
      Point(5, 3),
      Point(4, 4),
      Point(5, 4),
      Point(4, 5),
      Point(5, 5),

      //MIDDLE
      Point(0, 6),
      Point(0, 7),
      Point(1, 6),
      Point(1, 7),
      Point(2, 6),
      Point(2, 7),
      Point(3, 6),
      Point(3, 7),
      Point(4, 6),
      Point(4, 7),
      Point(5, 6),
      Point(5, 7),
    ],
    "0": [
      //TOP
      Point(0, 0),
      Point(0, 1),
      Point(1, 0),
      Point(1, 1),
      Point(2, 0),
      Point(2, 1),
      Point(3, 0),
      Point(3, 1),
      Point(4, 0),
      Point(4, 1),
      Point(5, 0),
      Point(5, 1),

      //BOTTOM
      Point(0, 12),
      Point(0, 13),
      Point(1, 12),
      Point(1, 13),
      Point(2, 12),
      Point(2, 13),
      Point(3, 12),
      Point(3, 13),
      Point(4, 12),
      Point(4, 13),
      Point(5, 12),
      Point(5, 13),

      //DOWN UP RIGHT
      Point(4, 8),
      Point(5, 8),
      Point(4, 9),
      Point(5, 9),
      Point(4, 10),
      Point(5, 10),
      Point(4, 11),
      Point(5, 11),

      //DOWN UP LEFT
      Point(0, 8),
      Point(1, 8),
      Point(0, 9),
      Point(1, 9),
      Point(0, 10),
      Point(1, 10),
      Point(0, 11),
      Point(1, 11),

      //UP DOWN LEFT
      Point(0, 2),
      Point(1, 2),
      Point(0, 3),
      Point(1, 3),
      Point(0, 4),
      Point(1, 4),
      Point(0, 5),
      Point(1, 5),

      //UP DOWN RIGHT
      Point(4, 2),
      Point(5, 2),
      Point(4, 3),
      Point(5, 3),
      Point(4, 4),
      Point(5, 4),
      Point(4, 5),
      Point(5, 5),

      //MIDDLE
      Point(0, 6),
      Point(0, 7),
      Point(1, 6),
      Point(1, 7),
      Point(4, 6),
      Point(4, 7),
      Point(5, 6),
      Point(5, 7),
    ]
  };
}
