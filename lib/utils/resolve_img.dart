import 'package:flutter/material.dart';

Widget fadeImg(String urlImg,
    {double? width, double? height, int duration = 90}) {
  if (urlImg.contains('assets/', 0)) {
    return FadeInImage(
      placeholder: AssetImage(urlImg),
      image: AssetImage(urlImg),
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
  return FadeInImage(
    image: Image.network(urlImg, width: width, height: height).image,
    width: width,
    height: height,
    imageErrorBuilder: (context, error, stackTrace) =>
        Image.asset('assets/images/placeholder.png'),
    placeholder: const AssetImage('assets/images/placeholder.png'),
    fit: BoxFit.cover,
  );
}
