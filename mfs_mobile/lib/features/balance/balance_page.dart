import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/ui/glass_card.dart';
import 'package:mfs_mobile/core/ui/app_button.dart';
import 'package:go_router/go_router.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with Riverpod providers (available balance, pending, etc.)
    final double available = 2500.75;
    final double pending = 132.40;
    final double hold = 0.0;
    const String lastUpdated = "Aug 10, 2025 • 09:24 AM";
    const String currency = "USD";

    Widget stat(String label, String value, {Widget? trailing}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.75))),
          Row(
            children: [
              Text(value,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              if (trailing != null) ...[
                const SizedBox(width: 8),
                trailing,
              ]
            ],
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Balance'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Available Balance Card
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Available Balance',
                    style: TextStyle(color: Colors.white.withOpacity(0.75))),
                const SizedBox(height: 8),
                Text('\$${available.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Updated $lastUpdated',
                    style:
                        TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Other Stats Card
          GlassCard(
            child: Column(
              children: [
                stat('Pending', '\$${pending.toStringAsFixed(2)}'),
                const SizedBox(height: 12),
                stat('Hold', '\$${hold.toStringAsFixed(2)}'),
                const SizedBox(height: 12),
                stat('Currency', currency),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Quick Actions
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Quick Actions',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Deposit',
                        onPressed: () => context.push('/deposit'),
                        color: Colors.greenAccent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppButton(
                        label: 'Transfer',
                        onPressed: () => context.push('/transfer'),
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Recent Activity
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recent Activity',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                ...[
                  ['Deposit • ACH', '+\$300.00', 'Today'],
                  ['Loan Repayment', '-\$120.00', 'Yesterday'],
                  ['Savings Sweep', '-\$50.00', 'Aug 12'],
                ].map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(e[0],
                                  style: const TextStyle(color: Colors.white))),
                          Text(e[2],
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12)),
                          const SizedBox(width: 10),
                          Text(e[1],
                              style: TextStyle(
                                color: e[1].startsWith('+')
                                    ? Colors.greenAccent
                                    : Colors.white,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}