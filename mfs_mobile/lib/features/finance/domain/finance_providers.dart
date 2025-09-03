// This file is deprecated - use core/providers/data_providers.dart instead
// All finance data is now fetched from the real backend API

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/data_providers.dart';

/// ---------------------------
/// Models
/// ---------------------------

class Transaction {
  final String title;
  final String subtitle;
  final double amount;
  final bool flaggedByAI;

  Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.flaggedByAI,
  });
}

class LoanData {
  final double totalLoans;
  final int activeLoans;
  final double repaymentProgress;
  final int overdueLoans;

  LoanData({
    required this.totalLoans,
    required this.activeLoans,
    required this.repaymentProgress,
    required this.overdueLoans,
  });
}

/// ---------------------------
/// Providers
/// ---------------------------

// Re-export the real providers for backward compatibility
final monthlyIncomeProvider = Provider<AsyncValue<double>>((ref) {
  final summary = ref.watch(dashboardSummaryProvider);
  return summary.when(
    data: (data) => AsyncValue.data(data.monthlyIncome),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final monthlyExpensesProvider = Provider<AsyncValue<double>>((ref) {
  final summary = ref.watch(dashboardSummaryProvider);
  return summary.when(
    data: (data) => AsyncValue.data(data.monthlyExpenses),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final recentTransactionsProvider = Provider<AsyncValue<List<dynamic>>>((ref) {
  final transactions = ref.watch(transactionsProvider);
  return transactions.when(
    data: (data) => AsyncValue.data(data.take(5).toList()),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

// Loan data provider using real backend data
final loanDataProvider = Provider<AsyncValue<LoanData>>((ref) {
  final loans = ref.watch(loansProvider);
  return loans.when(
    data: (loansList) {
      final activeLoans = loansList.where((l) => l.status == 'approved').toList();
      final totalAmount = activeLoans.fold(0.0, (sum, loan) => sum + loan.principal);
      
      return AsyncValue.data(LoanData(
        totalLoans: totalAmount,
        activeLoans: activeLoans.length,
        repaymentProgress: 0.65, // This would need to be calculated based on repayment data
        overdueLoans: 0, // This would need to be calculated based on due dates
      ));
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

/// ---------------------------
/// Derived Providers
/// ---------------------------

// Derived provider: Savings rate = (income - expenses) / income
final savingsRateProvider = Provider<double?>((ref) {
  final summary = ref.watch(dashboardSummaryProvider);
  return summary.when(
    data: (data) {
      if (data.monthlyIncome > 0) {
        final rate = (data.monthlyIncome - data.monthlyExpenses) / data.monthlyIncome;
        return rate.clamp(-1.0, 1.0);
      }
      return null;
    },
    loading: () => null,
    error: (_, __) => null,
  );
});