import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:state_management_ex1/activities/activity.dart';
import 'package:state_management_ex1/edit_pages/activity_card_edit.dart';
import 'package:state_management_ex1/edit_pages/edit_activity.dart';
import 'package:state_management_ex1/models/parse_date.dart';
import 'package:state_management_ex1/shared/constant.dart';

class CalendarDayBuilderEdit extends StatefulWidget {
  final DateTime rawDate;
  CalendarDayBuilderEdit({this.rawDate});

  @override
  _CalendarDayBuilderEditState createState() => _CalendarDayBuilderEditState();
}

class _CalendarDayBuilderEditState extends State<CalendarDayBuilderEdit> {
  List<Activity> dailyActivities;
  @override
  void initState() {
    dailyActivities = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Activity>>(
      stream: getDailyClassList(context, widget.rawDate),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return SimpleLoading();
        else if (snapshot.hasError) {
          return Text("ERROR");
        } else {
          return Column(
            children: [
              RaisedButton(
                child: Text("הוספת שיעור היום",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditActivity(
                              date: widget.rawDate,
                              add: true,
                              updateEdit: updateEdit)));
                },
              ),
              classlistView(snapshot, widget.rawDate),
            ],
          );
        }
      },
    );
  }

  Stream<List<Activity>> getDailyClassList(
      context, DateTime dateString) async* {
    await FirebaseFirestore.instance
        .collection('Activities')
        .doc(rawDateToDateString(dateString))
        .collection("classes")
        .get()
        .then((snapshot) {
      dailyActivities = snapshot.docs
          .map((spElement) => Activity.fromSnapshot(spElement.data()))
          .toList();
    });
    yield dailyActivities;
  }

  Widget classlistView(
      AsyncSnapshot<List<Activity>> listSnapshot, DateTime rawDate) {
    if (!listSnapshot.hasData) {
      return SimpleLoading();
    } else if (listSnapshot.data.isEmpty) {
      return NoActivityDayWidget();
    } else {
      listSnapshot.data.sort((act1, act2) {
        if (act1.rawDate.hour > act2.rawDate.hour)
          return 1;
        else
          return -1;
      });
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, position) => ActivityCardEdit(
              activity: listSnapshot.data[position],
              updateParentView: updateEdit),
          itemCount: listSnapshot.data?.length ?? 0,
        ),
      );
    }
  }

  updateEdit() {
    setState(() {});
  }
}

class NoActivityDayWidget extends StatelessWidget {
  const NoActivityDayWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Nothing here today\n           All day",
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        SizedBox(height: 20.0),
        Icon(
          Icons.free_breakfast,
          size: 54.0,
        ),
      ],
    );
  }
}
