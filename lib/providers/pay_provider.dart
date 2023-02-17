import 'dart:convert';

import 'package:pay_crypto/configuration.dart';
import 'package:pay_crypto/model/pay_model.dart';
import 'package:pay_crypto/preference/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:pay_crypto/utils/global.dart';
import "./../utils/utils.dart" as util;

class PayProvaider {
  final PreferenceUser preferenceUser = PreferenceUser();

  final String _urlTolist = "pay/to-list";
  final String _urlGenerater = "pay/generate";
  final String _urlConfirm = "pay/check";
  final String _urlBalance = "pay/balance";

  Future<List<PayModel>> toListPayament(String date) async {
    var clientHttp = http.Client();
    List<PayModel> listPay = [];
    try {
      final response = await clientHttp.post(
          Uri.parse(System.apiUrl + _urlTolist),
          headers: util.headers,
          body: {
            "collection": date,
            "wallet": preferenceUser.auth,
          });
      Map<String, dynamic> decodeData = json.decode(response.body);
      if (decodeData["status"] == 1) {
        for (var item in decodeData['1']) {
          listPay.add(PayModel.fromJson(item));
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('pay_provider error:  $e');
    } finally {
      clientHttp.close();
    }

    return listPay;
  }

  //esto es lo q vamos a enviar al back para el pago y registro en red de solana,
  //los datos del body son los requeridos en la libreria solana pay
  generatePay(
      PayModel paymodel, DateTime date, Function responseGenerate) async {
    var client = http.Client();
    try {
      final response = await client.post(
        Uri.parse(System.apiUrl + _urlGenerater),
        headers: util.headers,
        body: {
          "date_time": date.toString(),
          "amount": paymodel.amount.toString(),
          "label": paymodel.label.toString(),
          "message": paymodel.message.toString(),
          "memo": date.toIso8601String().toString().replaceFirst("T", ' '),
          "wallet": preferenceUser.auth,
        },
      );
      Map<String, dynamic> decodeData = json.decode(response.body);
      if (decodeData["status"] == 1) {
        return responseGenerate(1, decodeData["1"]);
      }
      return responseGenerate(0, decodeData["error"]);
    } catch (e) {
      // ignore: avoid_print
      print('pay_provider error: $e');
    } finally {
      client.close();
    }
    return responseGenerate(0, Global.msgNoConnectionInternet);
  }

  confirmPay(PayModel paymodel, Function responseConfirm) async {
    var client = http.Client();
    try {
      final response = await client.post(
        Uri.parse('${System.apiUrl}$_urlConfirm/${paymodel.documentId}'),
        headers: util.headers,
        body: {
          "secret_key": paymodel.secretKey,
          "collection": paymodel.collection,
          "wallet": preferenceUser.auth,
        },
      );
      Map<String, dynamic> decodeData = json.decode(response.body);
      if (decodeData["status"] == 1) {
        return responseConfirm(1, "Pago confirmado!");
      }
      return responseConfirm(0, decodeData["error"]);
    } catch (e) {
      // ignore: avoid_print
      print('pay_provider error: $e');
    } finally {
      client.close();
    }
    return responseConfirm(0, Global.msgNoConnectionInternet);
  }

  balance(Function responseBalance) async {
    var client = http.Client();
    try {
      final response = await client.post(
        Uri.parse('${System.apiUrl}$_urlBalance'),
        headers: util.headers,
        body: {
          "wallet": preferenceUser.auth,
        },
      );
      Map<String, dynamic> decodeData = json.decode(response.body);
      if (decodeData["status"] == 1) {
        return responseBalance(1, decodeData["sol"], decodeData["usdc"]);
      }
      return responseBalance(0, 0, 0);
    } catch (e) {
      // ignore: avoid_print
      print('pay_provider error: $e');
    } finally {
      client.close();
    }
    return responseBalance(0, 0, 0);
  }
}
