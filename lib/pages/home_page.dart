import 'package:flutter/material.dart';
import 'package:state_management_ex1/models/auth.dart';
import 'package:state_management_ex1/tabs/calendar_tab.dart';
import 'package:state_management_ex1/tabs/history_tab.dart';
import 'package:state_management_ex1/tabs/messages_tab.dart';

class HomePageCalendar extends StatelessWidget {
  HomePageCalendar({
    Key key,
  }) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text(
            'קרנף ירוק - פרדס חנה',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  color: Colors.blueGrey,
                  onPressed: () async => await _auth.signOut(),
                  child: Text("Logout")),
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calendar_today), text: 'לו"ז'),
              Tab(icon: Icon(Icons.history), text: "הרשמות"),
              Tab(icon: Icon(Icons.message), text: "הודעות"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CalendarTab(),
            HistoryTab(),
            MessagesTab(),
          ],
        ),
      ),
    );
  }
}
