import 'dart:ffi';

import 'package:flutter/material.dart';

import './custom_style.dart' as cs;

viewDialog(
  BuildContext context,
  String message, {
  Function? leftFunction,
  String? leftLabel = "Aceptar",
  Function? rightFunction,
  String? rightLabel = "Cancelar",
  String? title = "Importante",
  Color color = Colors.redAccent,
  Color colorTitle = Colors.black,
  IconData icon = Icons.cancel,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(
          title.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: cs.colorTextTitle,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SizedBox(
          width: 350.0,
          child: Text(message.toString()),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (leftFunction == null) {
                Navigator.of(context).pop;
              } else {
                leftFunction();
              }
            },
            child: Text(
              leftLabel.toString(),
            ),
          ),
          (rightFunction == null)
              ? Container()
              : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.colorBtnSecondary,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  label: Text(
                    rightLabel.toString(),
                  ),
                  icon: Icon(
                    icon,
                    size: 18.0,
                  ),
                  onPressed: rightFunction as Void Function()?,
                ),
        ],
      );
    },
  );
}
