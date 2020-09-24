// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../activities/Activity.dart';

// class MyModel extends ChangeNotifier {
//   final activitiesDB = FirebaseFirestore.instance.collection('Activities');
//   final Map<String, List<Activity>> activities = {};
//   final Set<String> registeredLessons = {};
//   final List<Activity> dailyActivities = [];
//   var _date;
//   MyModel() {
//     _date = DateTime.now();
//   }

//   int get weekDay => (_date.weekday + 1) % 7;
//   DateTime get rawDate => _date;
//   String get dateString => _date.toString().substring(0, 10);

//   void updateDay(date) {
//     _date = date;
//     notifyListeners();
//   }

//   void addActivity(String datet, Activity act) {
//     if (activities[datet] == null) {
//       activities[datet] = [];
//     }
//     if (activities[datet].contains(act)) {
//       return;
//     }
//     activities[datet].add(act);

//     // notifyListeners();
//   }

//   void printSchedule() {
//     activities.forEach((key, value) {
//       print("date is $key, activities: $value");
//     });
//   }
// }
