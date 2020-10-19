import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:state_management_ex1/activities/activity.dart';
import 'package:state_management_ex1/models/data_from_server.dart';
import 'package:state_management_ex1/shared/constant.dart';

class RegisteredList extends StatefulWidget {
  final Activity activity;

  const RegisteredList({Key key, this.activity}) : super(key: key);
  @override
  _RegisteredListState createState() => _RegisteredListState();
}

class _RegisteredListState extends State<RegisteredList> {
  List<dynamic> registeredUsers;
  String newName = '';

  @override
  void initState() {
    super.initState();
    registeredUsers = [];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>>(
      stream: getActivityRegisteredList(),
      builder: (context, snapshot) {
        print(registeredUsers);
        if (snapshot.hasError) {
          return Text("ERROR");
        } else {
          return ListView(
            children: [
              if (!snapshot.hasData)
                Center(
                    child: Text("אין רשומים", style: TextStyle(fontSize: 30.0)))
              else
                Center(
                    child: Text('${widget.activity.dateString} רשומים',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            decoration: TextDecoration.underline))),
              if (snapshot.hasData)
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, position) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      unregisterButton(snapshot.data[position]),
                      Text(
                        snapshot.data[position],
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.right,
                      )
                    ],
                  ),
                  itemCount: snapshot.data?.length ?? 0,
                ),
              registerNewButton()
            ],
          );
        }
      },
    );
  }

  Stream<List<dynamic>> getActivityRegisteredList() async* {
    await FirebaseFirestore.instance
        .collection('Activities')
        .doc(widget.activity.dateString)
        .collection("classes")
        .doc(widget.activity.name)
        .get()
        .then((snapshot) {
      registeredUsers = snapshot.data()['registeredUsers'].toList();
    });

    yield registeredUsers;
  }

  registerNewButton() {
    return Column(
      children: [
        TextFormField(
          textAlign: TextAlign.right,
          decoration: textInputDecoration.copyWith(hintText: 'שם מתאמן'),
          style: TextStyle(fontSize: 24.0),
          validator: (val) => (val == null && val == '') ? 'הכנס שם' : null,
          onChanged: (val) {
            newName = val;
          },
        ),
        RaisedButton(
          child: Text('הוספה', style: TextStyle(fontSize: 24.0)),
          onPressed: () async {
            print(newName);
            if (newName != null && newName != '') {
              await DataFromServerInit.addFromEdit(
                  widget.activity.dateString, widget.activity.name, newName);
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  unregisterButton(currentName) {
    return RaisedButton(
      child: Text('הסרה', style: TextStyle(fontSize: 24.0)),
      onPressed: () async {
        await DataFromServerInit.removeFromEdit(
            widget.activity.dateString, widget.activity.name, currentName);
        setState(() {});
      },
    );
  }
}
