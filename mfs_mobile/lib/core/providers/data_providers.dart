import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../models/transaction_model.dart';
import '../models/user_model.dart';
import '../models/balance_model.dart' as balance_model;
import '../models/loan_model.dart' as loan_model;
import 'auth_provider.dart';

// Balance provider
final balanceProvider = FutureProvider<balance_model.Balance?>((ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isAuthenticated) return null;
  
  final apiService = ref.watch(apiServiceProvider);
  try {
    return await apiService.getBalance();
  } catch (e) {
    throw Exception('Failed to load balance: $e');
  }
});

// Transactions provider
final transactionsProvider = FutureProvider<List<Transaction>>((ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isAuthenticated) return [];
  
  final apiService = ref.watch(apiServiceProvider);
  try {
    return await apiService.getTransactions();
  } catch (e) {
    throw Exception('Failed to load transactions: $e');
  }
});

// Recent transactions (last 5)
final recentTransactionsProvider = Provider<AsyncValue<List<Transaction>>>((ref) {
  final transactionsAsync = ref.watch(transactionsProvider);
  return transactionsAsync.when(
    data: (transactions) => AsyncValue.data(
      transactions.take(5).toList(),
    ),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

// Loans provider
final loansProvider = FutureProvider<List<loan_model.Loan>>((ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isAuthenticated) return [];
  
  final apiService = ref.watch(apiServiceProvider);
  try {
    return await apiService.getLoans();
  } catch (e) {
    throw Exception('Failed to load loans: $e');
  }
});

// Deposits provider
final depositsProvider = FutureProvider<List<Transaction>>((ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isAuthenticated) return [];
  
  final apiService = ref.watch(apiServiceProvider);
  try {
    return await apiService.getDeposits();
  } catch (e) {
    throw Exception('Failed to load deposits: $e');
  }
});

// Withdrawals provider
final withdrawalsProvider = FutureProvider<List<Transaction>>((ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isAuthenticated) return [];
  
  final apiService = ref.watch(apiServiceProvider);
  try {
    return await apiService.getWithdrawals();
  } catch (e) {
    throw Exception('Failed to load withdrawals: $e');
  }
});

// Transfers provider
final transfersProvider = FutureProvider<List<Transaction>>((ref) async {
  final authState = ref.watch(authProvider);
  if (!authState.isAuthenticated) return [];
  
  final apiService = ref.watch(apiServiceProvider);
  try {
    return await apiService.getTransfers();
  } catch (e) {
    throw Exception('Failed to load transfers: $e');
  }
});

// Dashboard summary data
class DashboardSummary {
  final double totalBalance;
  final int totalTransactions;
  final int activeLoans;
  final double monthlyIncome;
  final double monthlyExpenses;

  DashboardSummary({
    required this.totalBalance,
    required this.totalTransactions,
    required this.activeLoans,
    required this.monthlyIncome,
    required this.monthlyExpenses,
  });
}

final dashboardSummaryProvider = Provider<AsyncValue<DashboardSummary>>((ref) {
  final balanceAsync = ref.watch(balanceProvider);
  final transactionsAsync = ref.watch(transactionsProvider);
  final loansAsync = ref.watch(loansProvider);

  // Wait for all data to load
  if (balanceAsync.isLoading || transactionsAsync.isLoading || loansAsync.isLoading) {
    return const AsyncValue.loading();
  }

  // Check for errors
  if (balanceAsync.hasError) return AsyncValue.error(balanceAsync.error!, StackTrace.current);
  if (transactionsAsync.hasError) return AsyncValue.error(transactionsAsync.error!, StackTrace.current);
  if (loansAsync.hasError) return AsyncValue.error(loansAsync.error!, StackTrace.current);

  // Calculate summary
  final balance = balanceAsync.value?.amount ?? 0.0;
  final transactions = transactionsAsync.value ?? [];
  final loans = loansAsync.value ?? [];

  // Calculate monthly income/expenses from transactions
  final now = DateTime.now();
  final thisMonth = DateTime(now.year, now.month);
  final thisMonthTransactions = transactions.where((t) => 
    t.timestamp.isAfter(thisMonth) && t.timestamp.isBefore(now)
  ).toList();

  final monthlyIncome = thisMonthTransactions
      .where((t) => t.type == 'deposit' || t.type == 'transfer')
      .fold(0.0, (sum, t) => sum + t.amount);

  final monthlyExpenses = thisMonthTransactions
      .where((t) => t.type == 'withdrawal')
      .fold(0.0, (sum, t) => sum + t.amount);

  return AsyncValue.data(DashboardSummary(
    totalBalance: balance,
    totalTransactions: transactions.length,
    activeLoans: loans.where((l) => l.status == 'approved').length,
    monthlyIncome: monthlyIncome,
    monthlyExpenses: monthlyExpenses,
  ));
});
