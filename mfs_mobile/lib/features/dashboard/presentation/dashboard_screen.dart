import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/dashboard_card.dart';
import '../../../core/widgets/mini_bar_chart.dart';
import '../../../core/widgets/income_expense_card.dart';
import '../../../core/widgets/loan_card.dart';
import '../../../features/ai/domain/ai_service.dart';
import '../../../features/finance/domain/finance_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spendingPrediction = ref.watch(aiSpendingPredictionProvider);
    final loanPrediction = ref.watch(aiLoanPredictionProvider);
    final income = ref.watch(monthlyIncomeProvider);
    final expenses = ref.watch(monthlyExpensesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: SafeArea(
        bottom: false, // bottom handled separately
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. AI Insights
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.deepPurpleAccent,
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AI Insights',
                        style: TextStyle(
                          fontSize: 20,
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

              // 2. Dashboard Cards
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.35,
                children: [
                  DashboardCard(
                    title: 'Balance',
                    value: '\$12,450',
                    startColor: Colors.tealAccent.shade700,
                    endColor: Colors.green.shade700,
                    icon: Icons.account_balance_wallet,
                    onTap: () {},
                  ),
                  DashboardCard(
                    title: 'Loans',
                    value: '\$3,200',
                    startColor: Colors.redAccent.shade700,
                    endColor: Colors.red.shade400,
                    icon: Icons.attach_money,
                    onTap: () {},
                  ),
                  DashboardCard(
                    title: 'Savings',
                    value: '\$7,500',
                    startColor: Colors.lightBlueAccent.shade700,
                    endColor: Colors.blue.shade400,
                    icon: Icons.savings,
                    onTap: () {},
                  ),
                  DashboardCard(
                    title: 'Credit Score',
                    value: '720',
                    startColor: Colors.orange.shade600,
                    endColor: Colors.deepOrange.shade400,
                    icon: Icons.star,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 3. Loan Card
              LoanCard(
                totalLoans: 125000.00,
                activeLoans: 48,
                repaymentProgress: 0.73,
                overdueLoans: 5,
              ),
              const SizedBox(height: 24),

              // 4. Income vs Expenses
              const Text(
                'Income vs Expenses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              IncomeExpenseCard(
                income: income.asData?.value ?? 0,
                expenses: expenses.asData?.value ?? 0,
              ),
              const SizedBox(height: 24),

              // 5. Mini Bar Chart
              const Text(
                'Spending Trends',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: MiniBarChart(
                  values: [10, 20, 15, 25, 18, 30, 22],
                  barColor: Colors.deepPurpleAccent,
                ),
              ),
              const SizedBox(height: 24),

              // 6. Recent Transactions
              const Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 16), // extra spacing for bottom menu
            ],
          ),
        ),
      ),

      // 7. Bottom Static Menu Bar
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        ),
      ),
    );
  }
}

// Quick Action Button Widget (flexible & smaller)
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
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                label,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}