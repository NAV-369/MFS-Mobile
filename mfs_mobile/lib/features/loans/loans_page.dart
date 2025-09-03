import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/ui/glass_card.dart';
import 'package:mfs_mobile/core/ui/app_button.dart';


class LoansPage extends StatelessWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with provider-backed data
    final Map<String, dynamic> summary = {
      'totalOutstanding': 1240.00,
      'activeLoans': 2,
      'overdue': 0,
      'nextDue': 'Aug 20, 2025',
      'nextAmount': 120.00,
    };

    final List<Map<String, dynamic>> loans = [
      {
        'title': 'Micro-Loan #8421',
        'amount': 800.00,
        'repayed': 0.65,
        'due': 'Aug 20',
        'status': 'On Track',
      },
      {
        'title': 'Equipment Loan #112',
        'amount': 440.00,
        'repayed': 0.30,
        'due': 'Sep 05',
        'status': 'Active',
      },
    ];

    Widget pill(String text, Color color) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: color.withOpacity(0.35)),
          ),
          child: Text(
            text,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        );

    Widget progress(double v) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: v,
            minHeight: 8,
            backgroundColor: Colors.white12,
            valueColor:
                const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
          ),
        );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Loans'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Outstanding',
                    style:
                        TextStyle(color: Colors.white.withOpacity(0.75))),
                const SizedBox(height: 6),
                Text(
                  '\$${(summary['totalOutstanding'] as double).toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    pill('${summary['activeLoans']} Active', Colors.white),
                    const SizedBox(width: 8),
                    pill(
                        '${summary['overdue']} Overdue',
                        (summary['overdue'] as int) == 0
                            ? Colors.greenAccent
                            : Colors.redAccent),
                    const Spacer(),
                    Text(
                      'Next: ${summary['nextDue']} • \$${(summary['nextAmount'] as double).toStringAsFixed(0)}',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...loans.map((l) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l['title'] as String,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Principal: \$${(l['amount'] as double).toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.75)),
                          ),
                          pill(l['status'] as String, Colors.blueAccent),
                        ],
                      ),
                      const SizedBox(height: 12),
                      progress(l['repayed'] as double),
                      const SizedBox(height: 6),
                      Text(
                        '${((l['repayed'] as double) * 100).toStringAsFixed(0)}% repaid • Due ${l['due']}',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              label: 'Repay',
                              onPressed: () {
                                // TODO: Navigate to repay flow
                              },
                              color: Colors.greenAccent,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppButton(
                              label: 'Details',
                              onPressed: () {
                                // TODO: Navigate to loan details
                              },
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}