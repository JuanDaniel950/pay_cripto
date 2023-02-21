import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//para ahorrarnos la pereza de estar buscando el codigo del color, podemos pasar un hex.
Color hexToColor(String codeColor) {
  return Color(int.parse(codeColor.substring(1, 7), radix: 16) + 0xFF000000);
}

const String colorSecond = "#512DA8"; //purpura;

get colorAppBar => hexToColor("#000000");
get colorBtnSecondary => hexToColor(colorSecond);
get colorBtnPrimary => hexToColor("#FFFFFF");
get colorTextBtnPrimary => hexToColor(colorSecond);
get colorProgressLine => hexToColor(colorSecond);
get colorTextTitle => hexToColor("#0E0525");
get colorTextInputLabel => hexToColor(colorSecond);
get colorLineBorder => hexToColor("#512DA8");
get colorIcons => hexToColor(colorSecond);

get widthForm {
  return 500.0;
}

get width {
  return 1100.0;
}

get iconAbout => Icon(FontAwesomeIcons.atlassian, color: colorIcons);

get iconNotification => Icon(
      FontAwesomeIcons.bell,
      color: colorIcons,
      size: 25.0,
    );

InputDecoration inputDecoration(String label, Widget? prefixIcon,
    {Widget? suffixIcon}) {
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(color: colorTextInputLabel),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    counterText: '',
    errorStyle: const TextStyle(color: Colors.red),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorLineBorder, width: 1.0),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: colorLineBorder, width: 1.0),
    ),
    contentPadding:
        const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0, right: 10.0),
  );
}
