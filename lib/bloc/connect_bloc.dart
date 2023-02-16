import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:pay_crypto/configuration.dart';
import 'package:pay_crypto/utils/global.dart';
import 'package:http/http.dart' as http;
import 'package:pay_crypto/utils/utils.dart' as utils;

class ConnectBloc {
  static ConnectBloc? instance;

  ConnectBloc._internal();

  factory ConnectBloc() {
    if (instance == null) {
      instance = ConnectBloc._internal();
      instance!.init();
    }
    return instance!;
  }

  final conectStreamCtrl = StreamController<int>.broadcast();
  Function(int) get changeStatus => conectStreamCtrl.sink.add;
  Stream<int> get conectStream => conectStreamCtrl.stream;

  void dispose() {
    conectStreamCtrl.close();
  }

  void init() {
    Connectivity().onConnectivityChanged.listen(checkConnectivity);
    Connectivity().checkConnectivity().then(checkConnectivity);
  }

  checkConnectivity(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile) {
      Global.message = "Conectado a internet por datos móviles";
      Global.icon = Icons.signal_cellular_4_bar;
      Global.color = Colors.green;
    } else if (result == ConnectivityResult.wifi) {
      Global.message = "Conectado a internet por wifi";
      Global.icon = Icons.wifi;
      Global.color = Colors.green;
    } else {
      Global.message = "No hay conexión a internet";
      Global.icon = Icons.signal_wifi_off;
      Global.color = Colors.red;
    }
    if (result != ConnectivityResult.none) {
      changeStatus(Global.disconnect);
    } else {
      bool isConnected = await (checkServerConnection());
      if (isConnected) {
        changeStatus(Global.connect);
      } else {
        Global.message = "Cambia de servidor";
        Global.icon = Icons.warning_amber_outlined;
        Global.color = Colors.yellow;
        changeStatus(Global.disconnect);
        check();
      }
    }
  }

  check() async {
    bool isConnected = await (checkServerConnection());
    if (isConnected) {
      changeStatus(Global.connect);
    } else {
      Future.delayed(Duration(seconds: 10), () {
        check();
      });
    }
  }

  Future<bool> checkServerConnection() async {
    var client = http.Client();

    try {
      final response = await client
          .get(Uri.parse(System.apiUrl), headers: utils.headers)
          .timeout(const Duration(seconds: 30));

      Map<String, dynamic> decodeData = json.decode(response.body);
      return decodeData['status'];
    } catch (e) {
      print('error connect bloc $e');
    } finally {
      client.close();
    }
    return false;
  }
}
