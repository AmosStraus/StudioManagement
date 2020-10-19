import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:state_management_ex1/activities/upcoming_activity_tile.dart';
import 'package:state_management_ex1/models/parse_date.dart';
import 'package:state_management_ex1/shared/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryTab extends StatefulWidget {
  final user;
  HistoryTab({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> with TickerProviderStateMixin {
  var dateString = "";
  var className = "";
  List<dynamic> upcomingList;

  @override
  void initState() {
    super.initState();
    upcomingList = [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            child: Text(
              ' סטודיו קרנף ירוק לאומנויות לחימה וג\'יו-ג\יטסו' +
                  ' בהדרכת איתי שטראוס. ',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.blue[800],
            child: Text(
              'איתי: 052-5013431',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onPressed: () async {
              // if (await canLaunch('tel:0525013431')) {
              try {
                await launch('tel:0525013431');
              } catch (e) {
                print('Could not launch');
              }
            },
          ),
          Text(":שיעורים עתידיים",
              style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic)),
          SizedBox(height: 20.0),
          StreamBuilder(
            stream: getUpcomingClassList(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SimpleLoading();
              } else if (snapshot.hasError) {
                return Text("ERROR");
              } else {
                if (snapshot.data.isEmpty ||
                    snapshot.data.every((t) => t == null)) {
                  return Center(
                    child: Text("אינך רשומ/ה לשיעורים בקרוב",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  );
                } else {
                  // not everything is null.
                  snapshot.data.removeWhere((t) => (t == null));
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, position) {
                      {
                        snapshot.data.sort((act1, act2) {
                          return dateStringComparator(
                              act1.split('_')[0], act2.split('_')[0]);
                        });
                        var splittedData = snapshot.data[position].split('_');
                        return UpcomingActivityCard(
                          rawDate: splittedData[0],
                          name: splittedData[1],
                          startTime:
                              splittedData.length > 2 ? splittedData[2] : "",
                        );
                      }
                    },
                    itemCount: snapshot.data?.length ?? 1,
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }

  Stream<List<dynamic>> getUpcomingClassList(context) async* {
    var mapFromServer = await FirebaseFirestore.instance
        .collection('Reports')
        .doc("${widget.user.displayName}_${widget.user.uid}")
        .get()
        .then((snapshot) {
      snapshot.data()['classHistory'].forEach((e) => print(e));
      return snapshot.data()['classHistory'].toList();
    });

    // upcoming activity list:
    // first element is DATE
    // second is the name of activity
    // filter the upcoming Dates
    upcomingList = mapFromServer.map((pair) {
      if (isUpComing(pair.keys.first)) {
        return pair.values.first;
      }
    }).toList();

    yield upcomingList;
  }
}
