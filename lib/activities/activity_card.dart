import 'package:flutter/material.dart';
import 'package:state_management_ex1/activities/activity.dart';
import 'package:state_management_ex1/models/auth.dart';

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
  bool full;

  @override
  void initState() {
    super.initState();
    currentUserID = auth.getUser.uid;
    registered = widget.activity.registeredUsers.contains(currentUserID);
  }

  @override
  Widget build(BuildContext context) {
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
          canRegisterToDay()
              ? Text(
                  "${widget.activity.registeredUsers?.length ?? 0} / ${widget.activity?.maxRegistered ?? 0}")
              : Container(),
          canRegisterToDay()
              ? (classIsNotFull() || userAlreadyRegistered())
                  ? MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      color: Colors.green[300],
                      child: Text(
                        userAlreadyRegistered() ? "בטל" : "הרשם",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () async {
                        if (userAlreadyRegistered()) {
                          widget.activity.registeredUsers.remove(currentUserID);
                          setState(() {});
                          await auth.registerUserToClass(
                              widget.activity, false);
                        } else {
                          widget.activity.registeredUsers.add(currentUserID);
                          setState(() {});
                          await auth.registerUserToClass(widget.activity, true);
                        }
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("מלא", style: TextStyle(fontSize: 20.0)),
                    )
              : Container()
        ],
      ),
    );
  }

  bool classIsNotFull() =>
      (widget.activity.registeredUsers.length < widget.activity.maxRegistered);

  bool userAlreadyRegistered() =>
      widget.activity.registeredUsers.contains(currentUserID);

  bool canRegisterToDay() {
    Duration difference = widget.activity.rawDate.difference(DateTime.now());
    return (difference.inMinutes - 180 > 0);
  }
}
