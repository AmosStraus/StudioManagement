import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessagesTab extends StatefulWidget {
  MessagesTab({
    Key key,
  }) : super(key: key);

  @override
  _MessagesTabState createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab>
    with TickerProviderStateMixin {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  List<Message> lastMessage = [];

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
    }

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        await FirebaseFirestore.instance
            .collection('Messages')
            .doc((DateTime.now().toString()))
            .set({
          'title': notification['title'],
          'body': notification['body'],
        });
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final notification = message['notification'];
        await FirebaseFirestore.instance
            .collection('Messages')
            .doc((DateTime.now().toString()))
            .set({
          'title': notification['title'],
          'body': notification['body'],
        });
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        final notification = message['notification'];
        await FirebaseFirestore.instance
            .collection('Messages')
            .doc((DateTime.now().toString()))
            .set({
          'title': notification['title'],
          'body': notification['body'],
        });
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(""),
        Center(
          child: Text(
            "הודעות",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        StreamBuilder(
          stream: getRecent(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, position) => Container(
                  padding: EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data[position].title,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data[position].body,
                            style: TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: snapshot.data?.length ?? 1,
              );
            } else {
              return Text("");
            }
          },
        ),
      ],
    );
  }

  Stream<List<Message>> getRecent() async* {
    lastMessage = [];
    await FirebaseFirestore.instance
        .collection('Messages')
        .get()
        .then((messages) {
      if (messages.docs != null) {
        if (messages.docs.length > 2) {
          lastMessage.add(
              Message.fromSnapshot(messages.docs[messages.docs.length - 3]));
        }
        if (messages.docs.length > 1) {
          lastMessage.add(
              Message.fromSnapshot(messages.docs[messages.docs.length - 2]));
        }
        if (messages.docs.length > 0) {
          lastMessage.add(
              Message.fromSnapshot(messages.docs[messages.docs.length - 1]));
        }
      }
    });
    yield lastMessage;
  }
}

class Message {
  final String title;
  final String body;

  const Message({@required this.title, @required this.body});

  Message.fromSnapshot(snapshot)
      : title = snapshot.data()['title'] ?? "No message",
        body = snapshot.data()['body'] ?? "";
}
