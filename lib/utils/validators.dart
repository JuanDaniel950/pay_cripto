String? validateMessage(String msg) {
  String message = msg.trim();
  if (message.length < 4) return 'Message required at least 4 characters';
  return null;
}

//validate amount
String? validatorsAmount(String amount) {
  String amt = amount.trim();
  if (amt.isEmpty) return 'Amount required';
  bool isValid = RegExp(r'^[0-9]+([.][0-9]+)?$').hasMatch(amt);
  if (!isValid) return 'used dot(.) for decimal';
  return null;
}

//validate Solana Address
String? validatorsAddress(String? address) {
  String addr = address!.trim();
  if (addr.length < 44) return 'Address required at least 44 characters';
  return null;
}

//validate alias
String? validatorAlias(String? nemo) {
  String alias = nemo!.trim();
  if (alias.length < 4) return 'Alias required at least 4 characters';
  return null;
}
