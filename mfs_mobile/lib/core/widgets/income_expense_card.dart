import 'package:flutter/material.dart';

class IncomeExpenseCard extends StatelessWidget {
  final double income;
  final double expenses;
  final String title;
  final VoidCallback? onTap;

  const IncomeExpenseCard({
    super.key,
    required this.income,
    required this.expenses,
    this.title = 'Income vs Expenses',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = income - expenses;
    final spentRatioRaw = income <= 0 ? 0.0 : expenses / income;
    final spentRatio = spentRatioRaw.clamp(0.0, 1.0);
    final overBudget = spentRatioRaw > 1.0;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Spacer(),
                  if (overBudget)
                    const _StatusChip(label: 'Over budget', color: Colors.red),
                  if (!overBudget && remaining >= 0)
                    const _StatusChip(label: 'On track', color: Colors.green),
                ],
              ),
              const SizedBox(height: 12),

              // Income row
              _LabeledAmount(
                label: 'Income',
                amount: income,
                color: Colors.green,
              ),
              const SizedBox(height: 6),
              _ProgressLine(
                value: 1.0, // Income baseline
                color: Colors.green,
              ),
              const SizedBox(height: 12),

              // Expenses row
              _LabeledAmount(
                label: 'Expenses',
                amount: expenses,
                color: overBudget ? Colors.red : Colors.orange,
              ),
              const SizedBox(height: 6),
              _ProgressLine(
                value: spentRatio,
                color: overBudget ? Colors.red : Colors.orange,
              ),

              const SizedBox(height: 12),
              // Footer summary
              Row(
                children: [
                  Icon(
                    overBudget ? Icons.warning_amber : Icons.savings,
                    size: 18,
                    color: overBudget ? Colors.red : Colors.blueAccent,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      overBudget
                          ? 'You exceeded income by \$${(expenses - income).toStringAsFixed(0)}'
                          : 'Remaining this month: \$${remaining.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledAmount extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;

  const _LabeledAmount({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const Spacer(),
        Text(
          '\$${amount.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

class _ProgressLine extends StatelessWidget {
  final double value; // 0..1
  final Color color;

  const _ProgressLine({
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        minHeight: 8,
        value: value,
        backgroundColor: Colors.grey.shade300,
        color: color,
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}