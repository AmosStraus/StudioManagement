import 'package:flutter/material.dart';
import 'package:state_management_ex1/models/auth.dart';
import 'package:state_management_ex1/models/parse_date.dart';

class UpcomingActivityCard extends StatefulWidget {
  final String name;
  final String rawDate;
  final String startTime;

  UpcomingActivityCard({Key key, this.name, this.rawDate, this.startTime})
      : super(key: key);

  @override
  _UpcomingActivityCardState createState() => _UpcomingActivityCardState();
}

class _UpcomingActivityCardState extends State<UpcomingActivityCard> {
  bool registered = true;
  final auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              parseDateToHebrew(widget.rawDate.substring(0, 10))
                      .substring(0, 5) +
                  " " +
                  widget.rawDate.substring(11, 16),
              style: TextStyle(fontSize: 20.0)),
          Text(widget.name, style: TextStyle(fontSize: 20.0)),
          registered
              ? MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Colors.green[300],
                  child: Text(
                    "בטל",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () async {
                    await auth.removeFromUpcoming(widget.rawDate, widget.name);
                    setState(() {
                      registered = false;
                    });
                  })
              : MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Colors.green[300],
                  child: Text(
                    "החזר",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () async {
                    await auth.addFromUpcoming(widget.rawDate, widget.name);
                    setState(() {
                      registered = true;
                    });
                  })
        ],
      ),
    );
  }
}
