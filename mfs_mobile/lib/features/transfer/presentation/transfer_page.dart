import 'package:flutter/material.dart';
import 'package:mfs_mobile/core/ui/glass_card.dart';
import 'package:mfs_mobile/core/ui/app_input.dart';
import 'package:mfs_mobile/core/ui/app_button.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = TextEditingController();
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Transfer"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GlassCard(
              child: Column(
                children: [
                  AppInput(
                    hint: "Recipient Account Number",
                    controller: accountController,
                  ),
                  const SizedBox(height: 12),
                  AppInput(
                    hint: "Recipient Name",
                    controller: nameController,
                  ),
                  const SizedBox(height: 12),
                  AppInput(
                    hint: "Enter Amount",
                    type: TextInputType.number,
                    controller: amountController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: AppButton(
                label: "Transfer",
                onPressed: () {
                  // ✅ Access values like this:
                  // print(accountController.text);
                  // print(nameController.text);
                  // print(amountController.text);
                },
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}