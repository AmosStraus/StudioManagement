import 'package:flutter/material.dart';
import 'package:state_management_ex1/models/parse_date.dart';

class Activity {
  String name;
  DateTime rawDate;
  Duration duration;
  int maxRegistered;
  List<dynamic> registeredUsers = [];

  Activity(
      {@required this.name,
      @required this.rawDate,
      @required this.duration,
      this.maxRegistered = 20,
      this.registeredUsers});

  Activity.withHour(Activity activity, DateTime currentDate) {
    name = activity.name;
    rawDate = DateTime(currentDate.year, currentDate.month, currentDate.day,
        activity.rawDate.hour, activity.rawDate.minute);
    duration = activity.duration;
    maxRegistered = activity.maxRegistered;
    registeredUsers = activity.registeredUsers;
  }

  Activity.fromSnapshot(snapshotData) {
    name = snapshotData['name'];
    duration = Duration(minutes: snapshotData['duration'] ?? 60);
    rawDate = snapshotData['rawDate'].toDate() ?? DateTime.now();
    maxRegistered = snapshotData['maxRegistered'] ?? 20;
    registeredUsers = snapshotData['registeredUsers'] ?? [];
  }

  Activity.fromSnapshotWithDate(snapshotData, DateTime actualDate) {
    DateTime snapshotDate = snapshotData['rawDate'].toDate() ?? DateTime.now();

    name = snapshotData['name'];
    duration = Duration(minutes: snapshotData['duration'] ?? 60);
    rawDate = DateTime(actualDate.year, actualDate.month, actualDate.day,
        snapshotDate.hour, snapshotDate.minute);
    maxRegistered = snapshotData['maxRegistered'] ?? 20;
    registeredUsers = snapshotData['registeredUsers'] ?? [];
  }

  Activity.dummy()
      : name = "dummy",
        rawDate = DateTime.now(),
        duration = Duration(seconds: 0);

  String get dateString => rawDate.toString().substring(0, 10);
  String get startTime => rawDate.toString().substring(11, 16);
  String get endTime => rawDate.add(duration).toString().substring(11, 16);
  String get weekDay => intToDay(weekDayIL(rawDate.weekday));

  @override
  String toString() {
    return "$name from $startTime to $endTime";
  }
}
