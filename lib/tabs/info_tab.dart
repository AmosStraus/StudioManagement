import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoTab extends StatefulWidget {
  const InfoTab({Key key}) : super(key: key);

  @override
  _InfoTabState createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              user.photoURL != null
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.network(
                        "${user.photoURL}",
                        scale: 0.1,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(),
              Column(
                children: [
                  Text(
                    "שלום",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "${user?.displayName ?? ""}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.blue[800],
              child: Text(
                'טופס אימוני כושר',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () async {
                // if (await canLaunch('tel:0525013431')) {
                try {
                  await launch(
                      'https://docs.google.com/spreadsheets/d/1r-KirLxAhj3yAwcoqjOJRDTViMy7ZoNrReo2lxXLe3E/edit?usp=drivesdk');
                } catch (e) {
                  print('Could not launch');
                }
              },
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.blue[800],
                child: Text(
                  'לאתר אינטרנט',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () async {
                  try {
                    await launch('https://www.team-straus.com');
                  } catch (e) {
                    print('Could not launch');
                  }
                }),
          ),
        ],
      ),
    );
  }
}
