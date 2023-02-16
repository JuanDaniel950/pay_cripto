import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:device_info/device_info.dart';
import 'package:pay_crypto/configuration.dart';
import 'package:pay_crypto/preference/shared_preference.dart';
import 'package:platform_info/platform_info.dart';

final PreferenceUser preferenceUser = PreferenceUser();

String marca = "";
String model = "";
String so = "";
String imei = "";
String iPD = "";
String pysics = "";

String cleanString(String str) {
  return str
      .toString()
      .replaceAll("'", "")
      .replaceAll("\'", "")
      .replaceAll(RegExp(r'[^\w\s]+'), '');
}

get headers => {
      "vs": "1.20.134",
      "idplataforma": System.isAndroid
          ? "1"
          : System.isIOS
              ? "2"
              : "3",
      "system": System().operatingSystem(),
      "marca": cleanString(marca),
      "modelo": cleanString(model),
      "so": cleanString(so),
      "imei": cleanString(imei),
      "referencia": "12.03.91",
      "ipd": cleanString(iPD),
      "key": cleanString(pysics),
    };

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

Future<bool> deviceDetails({String uuid = ""}) async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if (System.isAndroid) {
    var build = await deviceInfoPlugin.androidInfo;
    marca = build.manufacturer;
    model = build.display;
    so = build.version.sdkInt.toString();
    iPD = build.isPhysicalDevice.toString();
    if (uuid == "") {
      pysics = generateMd5(build.androidId);
      imei = generateMd5('$marca-$pysics-$model-${System.idAppPay}');
    } else {
      pysics = generateMd5(uuid);
      imei = generateMd5('$marca-$pysics-$model-${System.idAppPay}');
    }
  } else if (System.isIOS) {
    var data = await deviceInfoPlugin.iosInfo;
    marca = data.model;
    model = data.name;
    so = data.systemVersion.toString();
    iPD = data.isPhysicalDevice.toString();
    if (uuid == "") {
      pysics = generateMd5(data.identifierForVendor);
      imei = generateMd5('$marca-$pysics-$model-${System.idAppPay}');
    } else {
      pysics = generateMd5(uuid);
      imei = generateMd5('$marca-$pysics-$model-${System.idAppPay}');
    }
  } else if (System.isWeb) {
    final Platform platform = Platform.instance;
    marca = platform.version.toLowerCase();
    if (marca.lastIndexOf("opr/") > 0) {
      marca = "opera";
    } else if (marca.lastIndexOf("firefox/") > 0) {
      marca = "firefox";
    } else if (marca.lastIndexOf("chrome/") > 0) {
      marca = "chrome";
    } else if (marca.lastIndexOf("safari/") > 0) {
      marca = "safari";
    } else if (marca.lastIndexOf("edge/") > 0) {
      marca = "edge";
    } else {
      marca = "otro";
    }
    so = "WEB";
    model = marca;
    iPD = "true";
    imei = generateMd5('$marca-$pysics-$model-${System.idAppPay}');
  }
  return true;
}
