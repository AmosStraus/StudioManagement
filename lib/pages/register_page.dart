import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:state_management_ex1/models/auth.dart';
import 'package:state_management_ex1/shared/constant.dart';

class Register extends StatefulWidget {
  final Function toggleFunc;
  Register({this.toggleFunc});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String name = "";
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
              title: Text('הרשמה לקרנף ירוק'),
              actions: [
                FlatButton.icon(
                    onPressed: widget.toggleFunc,
                    icon: Icon(Icons.person_pin),
                    label: Text('להתחברות'))
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
                          textInputDecoration.copyWith(hintText: 'אימייל'),
                      style: TextStyle(fontSize: 20.0),
                      validator: (val) => val.isEmpty ? "הכנס מייל" : null,
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
                          textInputDecoration.copyWith(hintText: 'סיסמה'),
                      style: TextStyle(fontSize: 20.0),
                      validator: (val) =>
                          val.length < 6 ? "סיסמה באורך 6 לפחות" : null,
                      onChanged: (val) {
                        // for password
                        setState(() => password = val);
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      textAlign: TextAlign.right,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'שם המתאמן'),
                      style: TextStyle(fontSize: 20.0),
                      validator: (val) => val.isEmpty ? "הכנס את שמך" : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.brown,
                      child: Text(
                        "הרשם",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  email.trim(), password.trim(), name.trim());
                          if (result == null && this.mounted) {
                            setState(() {
                              error =
                                  "מייל לא תקין \n(אם אתה כבר רשום עבור להתחברות)";
                              loading = false;
                            });
                          } else {
                            setState(() => loading = false);
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    GoogleSignInButton(
                      onPressed: () async {
                        await _auth.googleSignIn();
                      },
                    ),
                    Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 20.0)),
                  ],
                ),
              ),
            ),
          );
  }
}
