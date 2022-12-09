class Transaction {
  final String? id;
  final double? amount;
  final String? title;
  final DateTime? dateTime;

  Transaction(
      {required this.id,
      required this.amount,
      required this.title,
      required this.dateTime});
}
