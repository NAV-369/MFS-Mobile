import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  final double totalLoans;
  final int activeLoans;
  final double repaymentProgress; // Value between 0.0 - 1.0
  final int overdueLoans;

  const LoanCard({
    Key? key,
    required this.totalLoans,
    required this.activeLoans,
    required this.repaymentProgress,
    required this.overdueLoans,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Loan Portfolio Overview",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "Total Loans Issued: \$${totalLoans.toStringAsFixed(2)}",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              "Active Loans: $activeLoans",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              "Overdue Loans: $overdueLoans",
              style: const TextStyle(color: Colors.redAccent, fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              "Repayment Progress",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: repaymentProgress,
              backgroundColor: Colors.white12,
              color: Colors.greenAccent,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 4),
            Text(
              "${(repaymentProgress * 100).toStringAsFixed(1)}% Completed",
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}