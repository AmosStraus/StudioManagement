import 'package:flutter/material.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:state_management_ex1/activities/activity.dart';
import 'package:state_management_ex1/edit_pages/registered_list._edit.dart';
import 'package:state_management_ex1/models/data_from_server.dart';
import 'package:state_management_ex1/shared/constant.dart';

class EditActivity extends StatefulWidget {
  final Function updateEdit;
  final bool add;
  final DateTime date;
  final Activity activity;
  EditActivity({this.add, this.date, this.activity, this.updateEdit});

  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends State<EditActivity> {
  // String name;
  TimeOfDay startTime;
  int updatedDuration;
  int updatedMaxRegistered;
  String newName;

  bool edit;
  bool updateRegistered;
  bool loading;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loading = false;
    edit = false;
    updateRegistered = false;
    if (widget.add) {
      newName = '';
      edit = true;
    } else {
      startTime = TimeOfDay.fromDateTime(widget.activity.rawDate);
      updatedDuration = widget.activity.duration.inMinutes;
      updatedMaxRegistered = widget.activity.maxRegistered;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.red[100],
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.red,
              title: Text(
                'מצב הוספה ועדכון',
              ),
            ),
            body: !(updateRegistered || edit)
                ? Center(
                    child: Column(children: [
                      SizedBox(height: 40),
                      MaterialButton(
                        color: Colors.white,
                        height: 80,
                        child: Text('עריכה', style: TextStyle(fontSize: 30.0)),
                        onPressed: () {
                          setState(() {
                            edit = true;
                          });
                        },
                      ),
                      SizedBox(height: 40),
                      MaterialButton(
                        color: Colors.white,
                        height: 80,
                        child: Text('עדכון רשומים',
                            style: TextStyle(fontSize: 30.0)),
                        onPressed: () {
                          setState(() {
                            updateRegistered = true;
                          });
                        },
                      )
                    ]),
                  )
                : updateRegistered
                    ? RegisteredList(activity: widget.activity)
                    : Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            Center(
                                child: widget.add
                                    ? Text('הוספת שיעור\n        שם',
                                        style: TextStyle(fontSize: 24.0))
                                    : Text(
                                        'עריכה של \n ${widget.activity.name}',
                                        style: TextStyle(fontSize: 24.0))),
                            widget.add
                                ? TextFormField(
                                    textAlign: TextAlign.right,
                                    decoration: textInputDecoration.copyWith(),
                                    style: TextStyle(fontSize: 24.0),
                                    validator: (val) =>
                                        (val == null && val == '')
                                            ? 'הכנס שם'
                                            : null,
                                    onChanged: (val) {
                                      newName = val;
                                    },
                                  )
                                : Container(),
                            SizedBox(
                              height: 20.0,
                            ),
                            RaisedButton(
                              child: Text(
                                  'שעת התחלה ' +
                                      '${startTime?.toString()?.substring(10, 15) ?? ''}',
                                  style: TextStyle(fontSize: 24.0)),
                              onPressed: () async {
                                startTime = await showIntervalTimePicker(
                                    interval: 5,
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        DateTime.now().subtract(Duration(
                                            minutes:
                                                TimeOfDay.now().minute % 5))));
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Center(
                                child: Text('משך (בדקות)',
                                    style: TextStyle(fontSize: 24.0))),
                            TextFormField(
                              initialValue: widget.add
                                  ? ''
                                  : widget?.activity?.duration?.inMinutes
                                      ?.toString(),
                              textAlign: TextAlign.right,
                              decoration: textInputDecoration.copyWith(),
                              style: TextStyle(fontSize: 24.0),
                              onChanged: (val) {
                                updatedDuration = num.parse(val.trim());
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Center(
                                child: Text('מספר משתתפי מרבי',
                                    style: TextStyle(fontSize: 24.0))),
                            TextFormField(
                              initialValue: widget.add
                                  ? ''
                                  : widget?.activity?.maxRegistered?.toString(),
                              textAlign: TextAlign.right,
                              decoration: textInputDecoration.copyWith(),
                              style: TextStyle(fontSize: 24.0),
                              onChanged: (val) {
                                updatedMaxRegistered = int.parse(val.trim());
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RaisedButton(
                              color: Colors.brown,
                              child: Text(
                                "${widget.add ? 'הוספה' : 'עדכון'}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28.0),
                              ),
                              onPressed: () async {
                                print((!widget.add ||
                                    (newName != null && newName != '')));
                                if ((!widget.add ||
                                    (newName != null && newName != ''))) {
                                  setState(() {
                                    loading = true;
                                  });
                                  DateTime updatedDate = DateTime(
                                      widget.date.year,
                                      widget.date.month,
                                      widget.date.day,
                                      startTime?.hour ?? 0,
                                      startTime?.minute ?? 0);

                                  print(updatedDate);
                                  print(updatedDuration);
                                  print(updatedMaxRegistered);
                                  if (widget.add) {
                                    await DataFromServerInit
                                        .addNewActivityFromEditPanel(
                                            updatedDate,
                                            updatedDuration ?? 60,
                                            updatedMaxRegistered ?? 15,
                                            newName ?? 'newClass');
                                  } else {
                                    await DataFromServerInit.updateActivity(
                                        updatedDate,
                                        updatedDuration,
                                        updatedMaxRegistered,
                                        widget.activity.name);
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                  widget.updateEdit();
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ],
                        )));
  }
}
