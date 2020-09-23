import 'package:flutter/material.dart';
import 'package:state_management_ex1/models/parse_date.dart';

class UpcomingActivityCard extends StatelessWidget {
  final String name;
  final String date;
  UpcomingActivityCard({Key key, this.name, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            parseDateToHebrew(date),
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
