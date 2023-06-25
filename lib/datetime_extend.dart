import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay operator +(Duration duration) {
    final int minutes = hour * 60 + minute + duration.inMinutes;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }

  bool operator >(TimeOfDay other) {
    return hour > other.hour || (hour == other.hour && minute > other.minute);
  }

  bool operator <(TimeOfDay other) {
    return hour < other.hour || (hour == other.hour && minute < other.minute);
  }
}
