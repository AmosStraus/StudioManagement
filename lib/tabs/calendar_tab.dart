import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:state_management_ex1/models/data_from_server.dart';
import 'package:state_management_ex1/models/my_model.dart';
import 'package:state_management_ex1/models/parse_date.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTab extends StatefulWidget {
  CalendarTab({Key key}) : super(key: key);

  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab>
    with TickerProviderStateMixin {
  final _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    var welcomeString = user?.displayName ?? "Welcome!";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<MyModel>(
        builder: (context, myModel, child) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${welcomeString.substring(0, welcomeString.length > 20 ? 20 : welcomeString.length)}",
                  style: TextStyle(fontSize: 20.0),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue[200],
                  ),
                  child: Text(
                      "בתאריך: ${parseDateToHebrew(myModel.dateString)}",
                      style: TextStyle(fontSize: 18.0)),
                ),
              ],
            ),
            TableCalendar(
              initialCalendarFormat: CalendarFormat.week,
              // availableCalendarFormats: const {CalendarFormat.week: ""},
              weekendDays: [6],
              calendarStyle: CalendarStyle(
                selectedColor: Colors.deepOrange[400],
                todayColor: Colors.deepOrange[200],
                markersColor: Colors.brown[700],
                outsideDaysVisible: false,
              ),
              headerStyle: HeaderStyle(
                formatButtonTextStyle:
                    TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
                formatButtonDecoration: BoxDecoration(
                  color: Colors.deepOrange[400],
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              calendarController: _calendarController,
              onDaySelected: (day, events) {
                myModel.updateDay(day ?? DateTime.now());
                // print(_calendarController.focusedDay);
                print(day);
              },
            ),
            //  DataFromServer1.activeDB.doc(myModel.dateString).collection('classes').get().then((snapshot) {
            // snapshot.docs.map((e) => Activity.fromSnapshot(e)).toList()
            Expanded(
              child: DataFromServer(
                rawDate: _calendarController.focusedDay ?? DateTime.now(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
