import 'package:flutter/widgets.dart';
import 'package:pay_crypto/model/client_model.dart';
import 'package:pay_crypto/preference/shared_preference.dart';

final PreferenceUser prefs = PreferenceUser();

logOut(BuildContext context) {
  prefs.auth = '';
  prefs.clientModel = ClientModel();

  return Navigator.of(context)
      .pushNamedAndRemoveUntil('register', (Route<dynamic> route) => false);
}

checkSession(BuildContext context) async {
  if (prefs.auth == '') {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil('register', (Route<dynamic> route) => false);
  }
}

checkLogin(BuildContext context) async {
  if (prefs.auth.length >= 44) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '');
  }
}
