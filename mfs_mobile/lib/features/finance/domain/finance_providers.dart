import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simulated async sources (replace later with real repos/APIs)
final monthlyIncomeProvider = FutureProvider<double>((ref) async {
  await Future.delayed(const Duration(milliseconds: 250));
  return 1850.00; // example income
});

final monthlyExpensesProvider = FutureProvider<double>((ref) async {
  await Future.delayed(const Duration(milliseconds: 250));
  return 1425.00; // example expenses
});

// Derived savings rate = (income - expenses) / income
final savingsRateProvider = Provider<double?>((ref) {
  final incomeA = ref.watch(monthlyIncomeProvider);
  final expenseA = ref.watch(monthlyExpensesProvider);

  if (incomeA.hasValue && expenseA.hasValue && (incomeA.value ?? 0) > 0) {
    final income = incomeA.value!;
    final expenses = expenseA.value!;
    final rate = (income - expenses) / income;
    // Clamp to a sensible range
    return rate.clamp(-1.0, 1.0);
  }
  return null;
});