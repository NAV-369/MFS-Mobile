import 'package:flutter_riverpod/flutter_riverpod.dart';

// Example: AI prediction for user spending habits
final aiSpendingPredictionProvider =
    FutureProvider.autoDispose<double>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  // Simulate AI calculating recommended spending limit
  return 1200.0; // USD recommended spending for the month
});

// Example: AI loan eligibility prediction
final aiLoanPredictionProvider =
    FutureProvider.autoDispose<String>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  // Simulate AI assessing loan approval
  return "Eligible for loan up to \$5,000";
});