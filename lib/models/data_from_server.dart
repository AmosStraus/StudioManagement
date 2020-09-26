import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:state_management_ex1/activities/activity.dart';
import 'package:state_management_ex1/models/parse_date.dart';

final Map<int, List<Activity>> schedulerLocal = {
  0: [
    Activity(
        name: "No Activity",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 24))
  ],
  1: [
    Activity(
        name: "class_slot_1",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_2",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_3",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_4",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_5",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_6",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_7",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_8",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_9",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_0",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
  ],
  2: [
    Activity(
        name: "class_slot_1",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_2",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_3",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_4",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_5",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_6",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_7",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_8",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_9",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_0",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
  ],
  3: [
    Activity(
        name: "class_slot_1",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_2",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_3",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_4",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_5",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_6",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_7",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_8",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_9",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_0",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
  ],
  4: [
    Activity(
        name: "class_slot_1",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_2",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_3",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_4",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_5",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_6",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_7",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_8",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_9",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_0",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
  ],
  5: [
    Activity(
        name: "class_slot_1",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_2",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_3",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_4",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_5",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_6",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_7",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_8",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_9",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_0",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
  ],
  6: [
    Activity(
        name: "class_slot_1",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_2",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_3",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_4",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_5",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_6",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_7",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_8",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_9",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
    Activity(
        name: "class_slot_0",
        rawDate: DateTime(2020, 1, 1, 0, 0),
        duration: Duration(hours: 0)),
  ],
};

class DataFromServerInit {
  static final Map<int, List<Activity>> schedulerRT = {};
  static const int DAYS_TO_LOAD = 30;
  static final activeDB = FirebaseFirestore.instance.collection('Activities');
  static final holidayDB = FirebaseFirestore.instance.collection('Holidays');
  static final schedulerDB = FirebaseFirestore.instance.collection('Scheduler');

  static loadScheduler() async {
    final schedulerDB = FirebaseFirestore.instance.collection('Scheduler');
    for (int i = 0; i < 7; ++i) {
      final List<Activity> temp = [];
      await schedulerDB
          .doc('$i ${intToDay(i)}')
          .collection("classes")
          .get()
          .then((snapshot) {
        if (!snapshot.docs.every(
            (element) => element.data()["name"].contains("class_slot_"))) {
          snapshot.docs.forEach((element) {
            if (!element
                .data()["name"]
                .contains(RegExp(r'(class_slot_|FREE)'))) {
              temp.add(Activity.fromSnapshot(element));
            }
          });
        }
      });
      schedulerRT[i] = temp;
    }
  }

  static pushScheduler() {
    for (int i = 0; i <= 7; ++i) {
      if (schedulerLocal[i] != null) {
        for (var activity in schedulerLocal[i]) {
          schedulerDB.doc('$i ${intToDay(i)}').set({
            'week day': activity.weekDay,
            'active day': activity.name != "No Activity",
            'date': activity.dateString,
          }, SetOptions(merge: false));
          schedulerDB
              .doc('$i ${intToDay(i)}')
              .collection('classes')
              .doc(activity.name)
              .set({
            'name': activity.name,
            'rawDate': activity.rawDate,
            'duration': activity.duration.inMinutes,
            'maxRegistered': activity.maxRegistered,
            'registeredUsers': activity.registeredUsers,
          }, SetOptions(merge: false));
        }
      }
    }
  }

  static loadDB() async {
    // The idea here is to set the next 60 days but not overwrite existing days
    // Also considers Holidays that were stated in the Firebase

    for (var i = 0; i < DAYS_TO_LOAD; i++) {
      DateTime currentDate = DateTime.now().add(Duration(days: i));
      String dateString = currentDate.toString().substring(0, 10);
      final dailyActivities = [];

      await activeDB.doc(dateString).get().then((snapshot) {
        if (!snapshot.exists) {
          if (schedulerRT[weekDayIL(currentDate.weekday)] != null) {
            for (var activity in schedulerRT[weekDayIL(currentDate.weekday)]) {
              dailyActivities.add(Activity.withHour(activity, currentDate));
            }
          } else {
            dailyActivities.add(Activity.withHour(
                schedulerRT[0][0], currentDate)); // class_slot_holiday
          }
          for (var activity in dailyActivities) {
            activeDB.doc(dateString).set({
              'week day': activity.weekDay,
              'active day': activity.name != "No Activity",
              'date': activity.dateString,
            }, SetOptions(merge: true));
            if (activity.name != "No Activity") {
              activeDB
                  .doc(dateString)
                  .collection('classes')
                  .doc(activity.name)
                  .set({
                'name': activity.name,
                'rawDate': activity.rawDate,
                'duration': activity.duration.inMinutes,
                'maxRegistered': activity.maxRegistered
              }, SetOptions(merge: true));
            }
          }
        }
      });
    }
  }

  static Future<void> updateServerOnRegistration(
      String dateString, Activity activity, bool register, User user) async {
    var f = register ? FieldValue.arrayUnion : FieldValue.arrayRemove;

    await activeDB
        .doc(dateString)
        .collection('classes')
        .doc(activity.name)
        .update({
      'registeredUsers': f([user.uid])
    });
  }
}
