import 'package:pay_crypto/model/client_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PreferenceUser {
  static PreferenceUser? _preferenceUser;
  PreferenceUser._internal();

  factory PreferenceUser() {
    _preferenceUser ??= PreferenceUser._internal();
    return _preferenceUser!;
  }

  init() async {
    try {
      _preferenceUser!.prefs = await SharedPreferences.getInstance();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  SharedPreferences? prefs;

  String get uuid {
    if (prefs!.getString('uuid') == null) {
      prefs!.setString('uuid', const Uuid().v4());
    }

    return prefs!.getString('uuid') ?? '';
  }

  set uuid(String uuid) {
    prefs!.setString('uuid', uuid);
  }

  set auth(String auth) {
    prefs!.setString('auth', auth);
  }

  String get auth {
    return prefs!.getString('auth') ?? '';
  }

  set clientModel(ClientModel client) {
    prefs!.setString('alias', client.alias.toString());
    prefs!.setString('wallet', client.wallet.toString());
  }

  ClientModel get clientModel {
    final client = ClientModel();
    client.alias = prefs!.getString('alias') ?? '';
    client.wallet = prefs!.getString('wallet') ?? '';

    return client;
  }
}
