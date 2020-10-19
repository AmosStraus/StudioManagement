import 'package:flutter/material.dart';
import 'package:state_management_ex1/edit_pages/calendar_tab_edit.dart';


class EditPage extends StatefulWidget {
  EditPage({Key key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'מצב עריכה',
        ),
      ),
      body: CalendarTabEdit(),
    );
  }
}
