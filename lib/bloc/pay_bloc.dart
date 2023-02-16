import 'dart:async';

import 'package:pay_crypto/model/pay_model.dart';
import 'package:pay_crypto/providers/pay_provider.dart';

class PayBloc {
  final PayProvaider payProvaider = PayProvaider();
  static PayBloc? instance;
  PayBloc._internal();

  factory PayBloc() {
    instance ??= PayBloc._internal();
    return instance!;
  }

  //lista de pagos
  List<PayModel> listPay = [];

  final _payStreamCtrl = StreamController<List<PayModel>>.broadcast();
  Function(List<PayModel>) get changeStatus => _payStreamCtrl.sink.add;
  Stream<List<PayModel>> get payStream => _payStreamCtrl.stream;

  Future<List<PayModel>> toListPayament(String date) async {
    final res = await payProvaider.toListPayament(date);
    listPay.clear();
    listPay.addAll(res);
    changeStatus(listPay);
    return res;
  }

  void dispose() {
    _payStreamCtrl.close();
  }
}
