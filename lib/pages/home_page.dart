import 'package:flutter/material.dart';
import 'package:state_management_ex1/edit_pages/edit_page.dart';
import 'package:state_management_ex1/models/auth.dart';
import 'package:state_management_ex1/tabs/calendar_tab.dart';
import 'package:state_management_ex1/tabs/history_tab.dart';
import 'package:state_management_ex1/tabs/info_tab.dart';
import 'package:state_management_ex1/tabs/messages_tab.dart';

class HomePageCalendar extends StatelessWidget {
  HomePageCalendar({
    Key key,
  }) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        onWillPop: () => showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: Text('יציאה', style: TextStyle(fontSize: 26)),
            content: Text("?באמת רוצה לצאת", style: TextStyle(fontSize: 20)),
            actions: [
              FlatButton(
                child: Text('כן', style: TextStyle(fontSize: 22)),
                onPressed: () => Navigator.pop(c, true),
              ),
              FlatButton(
                child: Text('לא', style: TextStyle(fontSize: 22)),
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
                padding: const EdgeInsets.all(5.0),
                child: PopupMenuButton<String>(
                  icon: Icon(Icons.menu, size: 35.0),
                  color: Colors.green[100],
                  onSelected: (String value) {
                    switch (value) {
                      case 'התנתקות':
                        showAlertDialog(context);
                        break;
                      case 'עריכה':
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => EditPage()));
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'התנתקות',
                        child: Text(
                          'התנתקות',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      if (['mokestra@gmail.com', 'itaistraus@gmail.com']
                          .contains(_auth.getUser.email))
                        PopupMenuItem<String>(
                          value: 'עריכה',
                          child: Text(
                            'עריכה',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                    ];
                  },
                ),
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.calendar_today), text: 'לו"ז'),
                Tab(icon: Icon(Icons.history), text: "הרשמות"),
                Tab(icon: Icon(Icons.message), text: "הודעות"),
                Tab(icon: Icon(Icons.explore), text: "כושר"),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              CalendarTab(),
              HistoryTab(user: _auth.getUser),
              MessagesTab(),
              InfoTab(),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("לא", style: TextStyle(fontSize: 22)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("כן", style: TextStyle(fontSize: 22)),
      onPressed: () async {
        await _auth.signOut();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("התנתקות", style: TextStyle(fontSize: 24)),
      content: Text("?האם תרצה להתנתק", style: TextStyle(fontSize: 22)),
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
