class Balance {
  final int id;
  final int userId;
  final double amount;
  final DateTime updatedAt;

  Balance({
    required this.id,
    required this.userId,
    required this.amount,
    required this.updatedAt,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'],
      userId: json['user_id'],
      amount: (json['amount'] as num).toDouble(),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
