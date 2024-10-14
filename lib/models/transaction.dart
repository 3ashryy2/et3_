class Transaction {
  final double amount;
  final String createdAt;

  Transaction({required this.amount, required this.createdAt});

  // Factory constructor to create a Transaction from a JSON response
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      createdAt: json['created_at'],
    );
  }
}
