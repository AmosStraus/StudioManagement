import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// filling the input and password  ///
const textInputDecoration = InputDecoration(
  alignLabelWithHint: true,
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.brown, width: 2.0),
  ),
);

/// The loading widget ///
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.green,
          size: 50.0,
        ),
      ),
    );
  }
}

class SimpleLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitChasingDots(
      color: Colors.green,
      size: 50.0,
    ));
  }
}
