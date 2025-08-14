import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/dashboard_card.dart';
import '../../../core/widgets/mini_bar_chart.dart';
import '../../../features/ai/domain/ai_service.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spendingPrediction = ref.watch(aiSpendingPredictionProvider);
    final loanPrediction = ref.watch(aiLoanPredictionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Dashboard Cards Grid (static all-in-one cards)
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.35,
              children: [
                DashboardCard(
                  title: 'Balance',
                  value: '\$12,450',
                  startColor: Colors.green,
                  endColor: Colors.teal,
                  icon: Icons.account_balance_wallet,
                  onTap: () {},
                ),
                DashboardCard(
                  title: 'Loans',
                  value: '\$3,200',
                  startColor: Colors.redAccent,
                  endColor: Colors.red,
                  icon: Icons.attach_money,
                  onTap: () {},
                ),
                DashboardCard(
                  title: 'Savings',
                  value: '\$7,500',
                  startColor: Colors.blue,
                  endColor: Colors.lightBlue,
                  icon: Icons.savings,
                  onTap: () {},
                ),
                DashboardCard(
                  title: 'Credit Score',
                  value: '720',
                  startColor: Colors.orange,
                  endColor: Colors.deepOrange,
                  icon: Icons.star,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 2. AI Insights Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: Colors.deepPurpleAccent,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AI Insights',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    spendingPrediction.when(
                      data: (value) => Text(
                        'Recommended spending this month: \$${value.toStringAsFixed(0)}',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                      loading: () => const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white)),
                      error: (err, stack) => const Text(
                          'Error fetching spending prediction',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 8),
                    loanPrediction.when(
                      data: (value) => Text(
                        'Loan Prediction: \$${double.tryParse(value) ?? 0}',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                      loading: () => const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white)),
                      error: (err, stack) => const Text(
                          'Error fetching loan prediction',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 3. Quick Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _QuickActionButton(
                    icon: Icons.attach_money,
                    label: 'Deposit',
                    color: Colors.green,
                    onTap: () {}),
                _QuickActionButton(
                    icon: Icons.swap_horiz,
                    label: 'Transfer',
                    color: Colors.blue,
                    onTap: () {}),
                _QuickActionButton(
                    icon: Icons.request_page,
                    label: 'Loan',
                    color: Colors.orange,
                    onTap: () {}),
              ],
            ),
            const SizedBox(height: 24),

            // 4. Mini Bar Chart (Example visual)
            const Text(
              'Spending Trends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: MiniBarChart(
                values: [10, 20, 15, 25, 18, 30, 22],
                barColor: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 24),

            // 5. Recent Transactions
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                bool flaggedByAI = index % 2 == 0;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        flaggedByAI ? Colors.redAccent : Colors.blueAccent,
                    child: const Icon(Icons.monetization_on,
                        color: Colors.white),
                  ),
                  title: Text('Transaction #${index + 1}'),
                  subtitle: const Text('Details of transaction'),
                  trailing: flaggedByAI
                      ? const Icon(Icons.warning, color: Colors.red)
                      : Text('\$${(index + 1) * 50}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Quick Action Button Widget
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}