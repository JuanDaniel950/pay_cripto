import 'dart:io';
import 'package:universal_platform/universal_platform.dart';

class System {
  static const String apiUrl = "http://localhost:3000/api";

  static const _idAppPay = 100000;
  static const titleAppPay = "Pay";

  static const appTitle = titleAppPay;

  static int get idAppPay => _idAppPay;
  static get isAndroid => UniversalPlatform.isAndroid;
  static get isIOS => UniversalPlatform.isIOS;
  static get isWeb => UniversalPlatform.isWeb;

  String operatingSystem() {
    return (System.isAndroid
        ? Platform.operatingSystem
        : System.isIOS
            ? Platform.operatingSystem
            : "Web");
  }
}
