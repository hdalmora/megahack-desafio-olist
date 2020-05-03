import 'package:flutter/cupertino.dart';

class Constants {

  static double MediaWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double MediaHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool MediaScreenBreakpoint(BuildContext context) {
    return MediaWidth(context) > 1200.0;
  }
}