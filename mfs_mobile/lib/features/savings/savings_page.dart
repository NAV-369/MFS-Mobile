import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/ui/glass_card.dart';
import 'package:mfs_mobile/core/ui/app_button.dart';


class SavingsPage extends StatelessWidget {
  const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example savings data (replace with provider or API later)
    final double totalSavings = 1250.75;
    final double goalAmount = 5000.0;
    final double progress = totalSavings / goalAmount; // ✅ double not num

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Savings"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Glass Card showing savings overview
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Savings",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${totalSavings.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0), // ✅ always double
                    backgroundColor: Colors.white12,
                    color: Colors.greenAccent,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${(progress * 100).toStringAsFixed(1)}% of \$${goalAmount.toStringAsFixed(0)} goal",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recent transactions (savings activity)
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    "Recent Activity",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Example saving deposits
                  GlassCard(
                    child: ListTile(
                      leading: const Icon(Icons.arrow_downward, color: Colors.greenAccent),
                      title: const Text("Deposit"),
                      subtitle: const Text("Aug 15, 2025"),
                      trailing: const Text(
                        "+\$250.00",
                        style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  GlassCard(
                    child: ListTile(
                      leading: const Icon(Icons.arrow_downward, color: Colors.greenAccent),
                      title: const Text("Deposit"),
                      subtitle: const Text("Aug 12, 2025"),
                      trailing: const Text(
                        "+\$100.00",
                        style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Action Button
            AppButton(
              label: "Add Savings",
              onPressed: () {
                // later open deposit workflow
              },
            ),
          ],
        ),
      ),
    );
  }
}