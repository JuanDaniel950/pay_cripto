class PayModel {
  String amount;
  String statusConfirmation;
  String label;
  String memo;
  String message;
  String secretKey;
  String wallet;

  String url;
  String collection;
  String documentId;

  PayModel(
      {this.amount = "",
      this.statusConfirmation = "",
      this.label = "",
      this.memo = "",
      this.message = "",
      this.secretKey = "",
      this.wallet = "",
      this.url = "",
      this.collection = "",
      this.documentId = ""});

  String get walletLitle {
    return '${wallet.substring(0, 4)} ... ${wallet.substring(wallet.length - 4, wallet.length)}';
  }

  factory PayModel.fromJson(Map<String, dynamic> json) => PayModel(
      amount: json["amount"] ?? '',
      statusConfirmation: json["statusConfirmation"] ?? '',
      label: json["label"] ?? '',
      memo: json["memo"] ?? '',
      message: json["message"] ?? '',
      secretKey: json["secretKey"] ?? '',
      wallet: json["wallet"] ?? '',
      url: json["url"] ?? '',
      collection: json["colletion"] ?? '',
      documentId: json["documentId"] ?? '');
}
