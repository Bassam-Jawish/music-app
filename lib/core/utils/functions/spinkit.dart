
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget spinKitApp() {
  return const SpinKitFadingCircle(
    key: Key('spin'),
    color: Colors.white,
    size: 30,
  );
}