import 'package:flutter/material.dart';
import 'package:pay_crypto/preference/shared_preference.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pay_crypto/utils/resolve_img.dart' as cache_img;
import 'package:pay_crypto/utils/custom_style.dart' as custom_style;
import 'package:pay_crypto/utils/dialog.dart' as dialog;
import 'package:pay_crypto/utils/permissions.dart' as permissions;
import 'package:pay_crypto/utils/utils.dart' as utils;

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final PreferenceUser _preferenceUser = PreferenceUser();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(context),
                    const Divider(),
                  ],
                ),
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    Container card = Container(
      margin: const EdgeInsets.only(
          top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          CircularPercentIndicator(
            radius: 20.0,
            lineWidth: 3.0,
            animation: true,
            percent: 1,
            center: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: cache_img.fadeImg(
                //se debe reemplazar po  una img real
                'assets/images/user.png',
                height: 20.0,
                width: 20.0,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: custom_style.colorBtnSecondary,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 175.0,
                child: Text(
                  _preferenceUser.clientModel.alias,
                  textScaleFactor: 1.4,
                  overflow: TextOverflow.fade,
                ),
              ),
              SizedBox(
                width: 175.0,
                child: Text(_preferenceUser.clientModel.wallet,
                    textScaleFactor: 0.9,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Colors.indigo,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
    return Stack(
      children: [
        card,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.blueAccent.withOpacity(0.6),
              onTap: () {
                dialog.viewDialog(context, '¿Deseas cambiar la Wallet?',
                    rightFunction: confLogOut,
                    rightLabel: 'Si, cambiar',
                    leftLabel: 'No, cancelar');
              },
            ),
          ),
        ),
      ],
    );
  }

  void confLogOut() {
    permissions.logOut(context);
  }

  Widget _footer() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15.0),
          child: ListTile(
            dense: true,
            leading: custom_style.iconNotification,
            title: const Text('Notificaciones'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'notifications');
            },
          ),
        ),
        ListTile(
          dense: true,
          leading: custom_style.iconAbout,
          title: const Text('Acerca de'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, 'about');
          },
        ),
        const Divider(
          height: 1.0,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          'V: ${utils.headers['vs']} JDPerez950 - Inspirado By Planck',
          textScaleFactor: 0.8,
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
