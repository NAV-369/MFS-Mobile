class Loan {
  final int id;
  final int userId;
  final double principal;
  final double interestRate;
  final int termMonths;
  final double monthlyPayment;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime? approvedAt;

  Loan({
    required this.id,
    required this.userId,
    required this.principal,
    required this.interestRate,
    required this.termMonths,
    required this.monthlyPayment,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.approvedAt,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'],
      userId: json['user_id'],
      principal: (json['principal'] as num).toDouble(),
      interestRate: (json['interest_rate'] as num).toDouble(),
      termMonths: json['term_months'],
      monthlyPayment: (json['monthly_payment'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      approvedAt: json['approved_at'] != null ? DateTime.parse(json['approved_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'principal': principal,
      'interest_rate': interestRate,
      'term_months': termMonths,
      'monthly_payment': monthlyPayment,
      'total_amount': totalAmount,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'approved_at': approvedAt?.toIso8601String(),
    };
  }
}
