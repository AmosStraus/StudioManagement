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
      child: WillPopScope(
        onWillPop: () => showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: Text('התנתקות'),
            content: Text("?האם תרצה להתנתק"),
            actions: [
              FlatButton(
                child: Text('כן'),
                onPressed: () => Navigator.pop(c, true),
              ),
              FlatButton(
                child: Text('לא'),
                onPressed: () => Navigator.pop(c, false),
              ),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.green[100],
          appBar: AppBar(
            elevation: 0,
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
                    onPressed: () async {
                      showAlertDialog(context);
                    },
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
              HistoryTab(user: _auth.getUser),
              MessagesTab(),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("לא"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("כן"),
      onPressed: () async {
        await _auth.signOut();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("התנתקות"),
      content: Text("?האם תרצה להתנתק"),
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
