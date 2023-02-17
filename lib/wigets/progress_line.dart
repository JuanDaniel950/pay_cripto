import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pay_crypto/bloc/connect_bloc.dart';
import 'package:pay_crypto/utils/global.dart';

class ProgressLine extends StatefulWidget {
  final StreamController<bool> changeStatus;

  const ProgressLine({super.key, required this.changeStatus});

  @override
  // ignore: no_logic_in_create_state
  State<ProgressLine> createState() => _ProgressLineState(changeStatus);
}

class _ProgressLineState extends State<ProgressLine>
    with TickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  StreamController<bool> changeStatus;
  _ProgressLineState(this.changeStatus);

  final ConnectBloc connectBloc = ConnectBloc();

  @override
  void initState() {
    super.initState();
    connectBloc.conectStream.listen((status) {
      execAnimation(status);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void disposeStream() {
    changeStatus.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: changeStatus.stream,
        builder: (context, snapshot) {
          return SizeTransition(
            sizeFactor:
                CurvedAnimation(parent: controller, curve: Curves.easeOut),
            axisAlignment: 0.0,
            child: Container(
              width: double.infinity,
              color: Global.color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Global.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Global.icon,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        });
  }

  execAnimation(int statusAnimation) {
    if (!mounted) return;
    if (Global.connected == Global.connect &&
        statusAnimation == Global.connect) {
      controller.forward();
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && Global.connected == Global.connect) {
          controller.reverse();
        }
      });
    }
  }
}
