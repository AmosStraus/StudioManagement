import 'package:flutter/material.dart';
import 'package:state_management_ex1/activities/activity.dart';
import 'package:state_management_ex1/edit_pages/edit_activity.dart';
import 'package:state_management_ex1/models/auth.dart';
import 'package:state_management_ex1/models/data_from_server.dart';

class ActivityCardEdit extends StatelessWidget {
  final updateParentView;
  final Activity activity;

  ActivityCardEdit({Key key, this.activity, this.updateParentView})
      : super(key: key);

  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                activity.name,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
              Text(
                activity.startTime + " to " + activity.endTime,
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
          Column(
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.red[300],
                child: Text(
                  "לעריכה",
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => EditActivity(
                              add: false,
                              activity: activity,
                              date: activity.rawDate,
                              updateEdit: updateParentView)));
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.red[300],
                child: Text(
                  "למחיקה",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  await showAlertDialog(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) async {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("לא",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("כן",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      onPressed: () async {
        await DataFromServerInit.deleteActivity(
            activity.dateString, activity.name);
        Navigator.pop(context);
        updateParentView();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("מחיקה",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
      content: Text("?האם באמת למחוק",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
