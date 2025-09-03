class Transaction {
  final int id;
  final String type;
  final double amount;
  final int userId;
  final int balanceId;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.userId,
    required this.balanceId,
    required this.timestamp,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: json['type'],
      amount: json['amount'].toDouble(),
      userId: json['user_id'],
      balanceId: json['balance_id'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'user_id': userId,
      'balance_id': balanceId,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class Balance {
  final int id;
  final int userId;
  final double amount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Balance({
    required this.id,
    required this.userId,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Loan {
  final int id;
  final int userId;
  final double principal;
  final double interestRate;
  final int termMonths;
  final String status;
  final DateTime createdAt;
  final DateTime? approvedAt;

  Loan({
    required this.id,
    required this.userId,
    required this.principal,
    required this.interestRate,
    required this.termMonths,
    required this.status,
    required this.createdAt,
    this.approvedAt,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'],
      userId: json['user_id'],
      principal: json['principal'].toDouble(),
      interestRate: json['interest_rate'].toDouble(),
      termMonths: json['term_months'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      approvedAt: json['approved_at'] != null 
          ? DateTime.parse(json['approved_at']) 
          : null,
    );
  }
}

class Notification {
  final int id;
  final int userId;
  final String title;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      message: json['message'],
      isRead: json['is_read'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
