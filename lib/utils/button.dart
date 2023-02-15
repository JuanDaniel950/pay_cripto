import 'package:flutter/material.dart';
import './custom_style.dart' as cs;

//Cada Btn esta por separado por si se le quiere dar un estilo diferente.

Widget btnIcon(String label, Icon icon, Function? onPressed) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.colorBtnSecondary,
        foregroundColor: cs.colorBtnPrimary,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: cs.colorBtnSecondary,
              width: 1.0,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon,
            const SizedBox(width: 20.0),
            Text(label),
          ],
        ),
      ),
    ),
  );
}

Widget btn(String label, Function? onPressed) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.colorBtnSecondary,
        foregroundColor: cs.colorBtnPrimary,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: cs.colorBtnSecondary,
              width: 1.0,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(label),
          ],
        ),
      ),
    ),
  );
}

Widget btnConfirm(String label, Function? onPressed) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.colorBtnSecondary,
        foregroundColor: cs.colorBtnPrimary,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: cs.colorBtnSecondary,
              width: 1.0,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(label),
          ],
        ),
      ),
    ),
  );
}
