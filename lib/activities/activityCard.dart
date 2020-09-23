import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_ex1/activities/activity.dart';
import 'package:state_management_ex1/models/auth.dart';
import 'package:state_management_ex1/models/parse_date.dart';

class ActivityCard extends StatefulWidget {
  final Activity activity;
  final DateTime rawDate;

  ActivityCard({Key key, this.activity, this.rawDate}) : super(key: key);

  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  final auth = AuthService();
  String currentUserID;
  bool registered;

  @override
  void initState() {
    super.initState();
    currentUserID = auth.getUser.uid;
    registered = widget.activity.registeredUsers.contains(currentUserID);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                widget.activity.name,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
              Text(
                widget.activity.startTime + " to " + widget.activity.endTime,
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
          Text(
              "${widget.activity.registeredUsers?.length ?? 0} / ${widget.activity?.maxRegistered ?? 0}"),
          canRegisterToDay(widget.activity.rawDate)
              ? MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Colors.green[300],
                  child: Text(
                    widget.activity.registeredUsers.contains(currentUserID)
                        ? "בטל"
                        : "הרשם",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () async {
                    print(
                        "${user.displayName} TO: ${widget.activity.name} AT ${widget.activity.dateString}");

                    if (widget.activity.registeredUsers
                        .contains(currentUserID)) {
                      widget.activity.registeredUsers.remove(currentUserID);
                      setState(() {});
                      await auth.registerUserToClass(widget.activity, false);
                    } else {
                      widget.activity.registeredUsers.add(currentUserID);
                      setState(() {});
                      await auth.registerUserToClass(widget.activity, true);
                    }
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
