import 'package:flutter/material.dart';

class Global {
  static const int none = -1;
  static const int connect = 1;
  static const int disconnect = 0;

  static String message = "wait...";
  static IconData icon = Icons.local_dining;
  static Color color = Colors.black12;
  static int connected = -1;
  static String connectivityResult = "x";
  static String msgNoConnectionInternet = "Conexiòn a internet no disponible";
}
