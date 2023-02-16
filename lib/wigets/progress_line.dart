import 'dart:async';

import 'package:flutter/material.dart';

class ProgressLine extends StatefulWidget {
  final StreamController<bool> changeStatus;

  const ProgressLine({super.key, required this.changeStatus});

  @override
  State<ProgressLine> createState() => _ProgressLineState();
}

class _ProgressLineState extends State<ProgressLine> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
