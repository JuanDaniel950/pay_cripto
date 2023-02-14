class ClientModel {
  String wallet;
  String alias;

  ClientModel({this.wallet = "", this.alias = ""});

  String get walletLitle {
    return '${wallet.substring(0, 4)} ... ${wallet.substring(wallet.length - 4, wallet.length)}';
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      ClientModel(wallet: json["wallet"], alias: json["alias"]);
}
