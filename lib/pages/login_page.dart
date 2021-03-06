import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:state_management_ex1/models/auth.dart';
import 'package:state_management_ex1/shared/constant.dart';

class Login extends StatefulWidget {
  final Function toggleFunc;
  Login({this.toggleFunc});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[200],
            appBar: AppBar(
              backgroundColor: Colors.green[600],
              title: Text('התחברות לקרנף ירוק'),
              actions: [
                FlatButton.icon(
                    onPressed: widget.toggleFunc,
                    icon: Icon(Icons.person),
                    label: Text('להרשמה'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Image.asset(
                      ("lib/assets/logo.png"),
                      scale: 0.1,
                      width: 150,
                      height: 150,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      textAlign: TextAlign.right,
                      decoration:
                          textInputDecoration.copyWith(hintText: "אימייל"),
                      style: TextStyle(fontSize: 20.0),
                      validator: (val) =>
                          val.isEmpty ? "הכנס כתובת מייל" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      textAlign: TextAlign.right,
                      decoration:
                          textInputDecoration.copyWith(hintText: "סיסמה"),
                      style: TextStyle(fontSize: 20.0),
                      validator: (val) =>
                          val.length < 6 ? "סיסמה באורך לפחות 6 תווים" : null,
                      onChanged: (val) {
                        // for password
                        setState(() => password = val);
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.brown,
                      child: Text(
                        "התחבר",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                                  email.trim(), password.trim());
                          if (result == null && this.mounted) {
                            setState(() {
                              error = "שם משתמש או סיסמה לא תקינים";
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    GoogleSignInButton(
                      onPressed: () async {
                        await _auth.googleSignIn();
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
