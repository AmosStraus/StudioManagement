import 'package:flutter/material.dart';
import 'package:state_management_ex1/activities/Activity.dart';


class ActiveDayList extends StatelessWidget {
  final Map<int, List<Activity>> activities;
  final DateTime currentDate;

  ActiveDayList({Key key, this.activities, this.currentDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final scheduler = DataFromServer1.schedulerRT;
    // final myModel = Provider.of<MyModel>(context, listen: false);
    // if (activities[myModel.dateString] == null) {
    //   if (scheduler[myModel.weekDay] != null) {
    //     for (var activity in scheduler[myModel.weekDay]) {
    //       Activity newActivity = Activity(
    //         name: activity.name,
    //         rawDate: DateTime(
    //             currentDate.year,
    //             currentDate.month,
    //             currentDate.day,
    //             activity.rawDate.hour,
    //             activity.rawDate.minute),
    //         duration: activity.duration,
    //         maxRegistered: activity.maxRegistered,
    //       );
    //       myModel.addActivity(myModel.dateString, newActivity);
    //     }
    //   } else {
    //     return Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           "Nothing here today\n           All day",
    //           style: TextStyle(
    //               fontSize: 24.0,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.blueGrey),
    //         ),
    //         SizedBox(height: 20.0),
    //         Icon(
    //           Icons.free_breakfast,
    //           size: 54.0,
    //         ),
    //       ],
    //     );
    //   }
    // }
    // Build the list //
    return Container();
    // return Consumer<MyModel>(
    //   builder: (context, value, child) => ListView.builder(
    //     itemBuilder: (context, position) => ActivityCard(
    //       activity: (activities[myModel.dateString])[position],
    //       rawDate: currentDate,
    //     ),
    //     itemCount: activities[myModel.dateString]?.length ?? 0,
    //   ),
    // );
  }
}
