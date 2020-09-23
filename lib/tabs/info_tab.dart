import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoTab extends StatefulWidget {
  const InfoTab({Key key}) : super(key: key);

  @override
  _InfoTabState createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  final _formKey = GlobalKey<FormState>();

  // text field state
  String name = "";
  String email = "";
  String password = "";
  String msg = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Sign up to Karnaf Yarok'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              if (user.photoURL != null)
                Image.network(
                  "${user.photoURL}",
                  scale: 0.1,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () async {
                  var res = await user.getIdTokenResult();
                  print(res.token);
                  setState(() {});
                },
              ),
              Text("$msg"),
            ],
          ),
        ),
      ),
    );
  }
}
