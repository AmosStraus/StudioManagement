import 'package:flutter/material.dart';
import 'package:state_management_ex1/edit_pages/calendar_activities_edit.dart';
import 'package:state_management_ex1/models/parse_date.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTabEdit extends StatefulWidget {
  CalendarTabEdit({Key key}) : super(key: key);

  @override
  _CalendarTabEditState createState() => _CalendarTabEditState();
}

class _CalendarTabEditState extends State<CalendarTabEdit> {
  final _calendarController = CalendarController();
  DateTime rawCurrDate;

  @override
  void initState() {
    super.initState();
    rawCurrDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          HeadLiner(rawCurrDate: rawCurrDate, welcomeString: 'מצב עריכה'),
          TableCalendar(
            initialCalendarFormat: CalendarFormat.twoWeeks,
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
              setState(() {
                rawCurrDate = _calendarController.focusedDay;
              });
            },
          ),
          Expanded(
            child: CalendarDayBuilderEdit(
              rawDate: _calendarController.focusedDay ?? DateTime.now(),
            ),
          ),
        ],
      ),
    );
  }
}

class HeadLiner extends StatelessWidget {
  const HeadLiner({
    Key key,
    @required this.rawCurrDate,
    @required this.welcomeString,
  }) : super(key: key);

  final DateTime rawCurrDate;
  final String welcomeString;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blue[200],
          ),
          child: Text(
              "בתאריך: ${parseDateToHebrew(rawDateToDateString(rawCurrDate))}",
              style: TextStyle(fontSize: 20.0)),
        ),
        Text(
          "${welcomeString.substring(0, welcomeString.length > 20 ? 20 : welcomeString.length)}",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
